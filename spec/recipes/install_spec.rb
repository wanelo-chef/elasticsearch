require 'spec_helper'

describe 'elasticsearch::install' do
  let(:runner) { ChefSpec::Runner.new { |node|
    node.set['elasticsearch']['version'] = '1.1.1'
  } }
  let(:chef_run) { runner.converge(described_recipe) }

  let(:tar_file) { "#{Chef::Config[:file_cache_path]}/elasticsearch-1.1.1.tar.gz" }

  it 'downloads elasticsearch' do
    expect(chef_run).to create_remote_file(tar_file)
  end

  describe 'remote_file[elasticsearch]' do
    let(:resource) { chef_run.remote_file(tar_file) }

    it 'notifies chef to untar the file' do
      expect(resource).to notify("execute[untar elasticsearch-1.1.1.tar.gz]").to(:run).immediately
    end
  end

  describe 'execute[untar elasticsearch]' do
    let(:resource) { chef_run.execute('untar elasticsearch-1.1.1.tar.gz') }

    it 'creates elasticsearch directory' do
      expect(resource.command).to include('mkdir -p /opt/elasticsearch')
    end

    it 'changes directory into elasticsearch dir' do
      expect(resource.command).to include('cd /opt/elasticsearch')
    end

    it 'untars the remote file' do
      expect(resource.command).to include("tar -xzf #{tar_file}")
    end

    it 'notifies chef to symlink elasticsearch' do
      expect(resource).to notify('link[/opt/local/lib/elasticsearch]').to(:create).immediately
    end
  end

  describe 'link[/opt/local/lib/elasticsearch]' do
    let(:resource) { chef_run.link('/opt/local/lib/elasticsearch') }

    it 'links to the untarred lib dir' do
      expect(resource.to).to eq('/opt/elasticsearch/elasticsearch-1.1.1/lib')
    end

    it 'notifies elasticsearch to restart' do
      expect(resource).to notify('service[elasticsearch]').to(:restart).delayed
    end
  end

  describe 'elasticsearch.in.sh' do
    context 'when a newrelic api key is set' do
      let(:runner) { ChefSpec::Runner.new { |node|
        node.set['elasticsearch']['newrelic']['api_key'] = 'i bought this already'
      } }

      it 'includes newrelic configuration' do
        expect(chef_run).to render_file('/opt/local/bin/elasticsearch.in.sh').with_content(/^JAVA_OPTS="\$JAVA_OPTS -javaagent:\$ES_HOME\/newrelic\/newrelic\.jar"$/)
      end
    end

    context 'when a newrelic api key is not set' do
      let(:runner) { ChefSpec::Runner.new { |node|
        node.set['elasticsearch']['newrelic']['api_key'] = ''
      } }

      it 'does not include newrelic configuration' do
        expect(chef_run).not_to render_file('/opt/local/bin/elasticsearch.in.sh').with_content(/^JAVA_OPTS="\$JAVA_OPTS -javaagent:\$ES_HOME\/newrelic\/newrelic\.jar"$/)
      end
    end
  end
end
