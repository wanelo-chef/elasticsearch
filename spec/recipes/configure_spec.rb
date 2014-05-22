require 'spec_helper'

describe 'elasticsearch::configure' do
  let(:runner) { ChefSpec::Runner.new }
  let(:chef_run) { runner.converge(described_recipe) }

  before do
    stub_search(:node, 'roles:elasticsearch-master').and_return([{'privateaddress' => '1.2.3.4'}])
  end

  it 'configures elasticsearch to not use multicast' do
    expect(chef_run).to render_file('/opt/local/etc/elasticsearch.yml').with_content(/^discovery\.zen\.ping\.multicast\.enabled: false$/)
  end

  describe 'unicast hosts' do
    it 'fills in ips based on search' do
      expect(chef_run).to render_file('/opt/local/etc/elasticsearch.yml').with_content(/^discovery\.zen\.ping\.unicast\.hosts: \["1\.2\.3\.4"\]$/)
    end

    context 'with search overridden' do
      let(:runner) { ChefSpec::Runner.new { |node|
          node.set['elasticsearch']['master_search'] = 'roles:blargh'
      } }

      before do
        stub_search(:node, 'roles:blargh').and_return([{'privateaddress' => '5.6.7.8'}])
      end

      it 'finds hosts based on node attributes' do
        expect(chef_run).to render_file('/opt/local/etc/elasticsearch.yml').with_content(/^discovery\.zen\.ping\.unicast\.hosts: \["5\.6\.7\.8"\]$/)
      end
    end
  end

  describe 'template[/opt/local/etc/elasticsearch.yml]' do
    let(:resource) { chef_run.template('/opt/local/etc/elasticsearch.yml') }

    it 'restarts elasticsearch' do
      expect(resource).to notify('service[elasticsearch]').to(:restart)
    end
  end
end
