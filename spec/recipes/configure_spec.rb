require 'spec_helper'

describe 'elasticsearch::configure' do
  let(:runner) { ChefSpec::Runner.new }
  let(:chef_run) { runner.converge(described_recipe) }

  before do
    stub_search(:node, 'roles:elasticsearch-master').and_return([{'privateaddress' => '5.6.7.8'}, {'privateaddress' => '1.2.3.4'}])
  end

  it 'configures elasticsearch to not use multicast' do
    expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^discovery\.zen\.ping\.multicast\.enabled: false$/)
  end

  it 'configures mlockall' do
    expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^bootstrap\.mlockall: true$/)
  end

  it 'configures the number of concurrent recovery streams' do
    expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^indices\.recovery\.concurrent_streams: 8$/)
  end

  it 'configures the recovery stream throttling' do
    expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^indices\.recovery\.max_bytes_per_sec: 512mb$/)
  end

  it 'configures the number of concurrent recoveries' do
    expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^cluster\.routing\.allocation\.node_concurrent_recoveries: 16$/)
  end

  it 'configures the number of initial recoveries' do
    expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^cluster\.routing\.allocation\.node_initial_primaries_recoveries: 4$/)
  end

  it 'configures the number of expected nodes in the cluster' do
    expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^gateway\.expected_nodes: 2$/)
  end

  describe 'cluster name' do
    let(:runner) { ChefSpec::Runner.new { |node|
        node.set['elasticsearch']['cluster'] = 'delicious-tacos'
    } }

    it 'configures the elasticsearch cluster name' do
      expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^cluster\.name: delicious-tacos/)
    end
  end

  describe 'node name' do
    context 'when no elasticsearch name is provided' do
      it 'configures the elasticsearch node name to the chef node name' do
        expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^node\.name: #{chef_run.node.name}/)
      end
    end

    context 'when elasticsearch name override is provided' do
      let(:runner) { ChefSpec::Runner.new { |node|
          node.set['elasticsearch']['name'] = 'clever-searching-name'
      } }

      it 'configures the elasticsearch node name' do
        expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^node\.name: clever-searching-name/)
      end
    end
  end

  describe 'minimum number of nodes' do
    let(:runner) { ChefSpec::Runner.new { |node|
        node.set['elasticsearch']['minimum_master_nodes'] = '30'
    } }

    it 'configures the minimum number of master-electable nodes' do
      expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^discovery\.zen\.minimum_master_nodes: 30/)
    end
  end

  describe 'processors' do
    it 'configures the number of processor' do
      expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^processors: 1/)
    end
  end

  describe 'plugin path' do
    it 'sets the plugin path' do
      expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^path\.plugins: \/opt\/local\/plugins/)
    end
  end

  describe 'master node' do
    it 'configures elasticsearch to not be master by default' do
      expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^node\.master: false$/)
    end

    context 'when the node is configured to be a master node' do
      let(:runner) { ChefSpec::Runner.new { |node|
          node.set['elasticsearch']['master'] = true
      } }

      it 'configures elasticsearch to be master-electable' do
        expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^node\.master: true/)
      end
    end
  end

  describe 'unicast hosts' do
    it 'fills in ips based on search' do
      expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^discovery\.zen\.ping\.unicast\.hosts: \["1\.2\.3\.4", "5\.6\.7\.8"\]$/)
    end

    context 'with search overridden' do
      let(:runner) { ChefSpec::Runner.new { |node|
          node.set['elasticsearch']['search'] = 'roles:blargh'
      } }

      before do
        stub_search(:node, 'roles:blargh').and_return([{'privateaddress' => '5.6.7.8'}])
      end

      it 'finds hosts based on node attributes' do
        expect(chef_run).to render_file('/opt/local/etc/elasticsearch/elasticsearch.yml').with_content(/^discovery\.zen\.ping\.unicast\.hosts: \["5\.6\.7\.8"\]$/)
      end
    end
  end

  describe 'logging' do
    describe 'syslog' do
      context 'when it is disabled (default)' do
        it 'does not log to syslog' do
          expect(chef_run).to render_file('/opt/local/etc/elasticsearch/logging.yml').with_content(/^rootLogger: \$\{es.logger.level\}, console, file$/)
        end
      end

      context 'when rsyslog is enabled' do
        let(:runner) { ChefSpec::Runner.new { |node|
          node.set['elasticsearch']['syslog']['server'] = '127.0.0.1'
          node.set['elasticsearch']['syslog']['port'] = '514'
          node.set['elasticsearch']['syslog']['enabled'] = true
          node.set['elasticsearch']['syslog']['facility'] = 'local2'
          node.set['elasticsearch']['syslog']['log_format'] = 'butts!'
        } }

        it 'logs to syslog' do
          expect(chef_run).to render_file('/opt/local/etc/elasticsearch/logging.yml').with_content(/^rootLogger: \$\{es.logger.level\}, console, file, syslog$/)
        end

        it 'has a configurable port and server' do
          expect(chef_run).to render_file('/opt/local/etc/elasticsearch/logging.yml').with_content('syslogHost: 127.0.0.1:514')
        end

        it 'has a configurable facility' do
          expect(chef_run).to render_file('/opt/local/etc/elasticsearch/logging.yml').with_content('facility: local2')
        end

        it 'has a configurable log format' do
          expect(chef_run).to render_file('/opt/local/etc/elasticsearch/logging.yml').with_content('conversionPattern: "butts!"')
        end
      end
    end
  end

end
