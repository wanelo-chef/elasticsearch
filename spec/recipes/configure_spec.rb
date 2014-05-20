require 'spec_helper'

describe 'elasticsearch::configure' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  before do
    stub_search(:node, 'roles:elasticsearch-master').and_return([{'privateaddress' => '1.2.3.4'}])
  end

  it 'configures elasticsearch to not use multicast' do
    expect(chef_run).to render_file('/opt/local/etc/elasticsearch.yml').with_content(/^discovery\.zen\.ping\.multicast\.enabled: false$/)
  end

  it 'configures the unicast hosts with the searchy things' do
    expect(chef_run).to render_file('/opt/local/etc/elasticsearch.yml').with_content(/^discovery\.zen\.ping\.unicast\.hosts: \["1\.2\.3\.4"\]$/)
  end

  describe 'template[/opt/local/etc/elasticsearch.yml]' do
    let(:resource) { chef_run.template('/opt/local/etc/elasticsearch.yml') }

    it 'restarts elasticsearch' do
      expect(resource).to notify('service[elasticsearch]').to(:restart)
    end
  end
end
