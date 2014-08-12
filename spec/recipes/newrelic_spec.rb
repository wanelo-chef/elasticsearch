require 'spec_helper'

describe 'elasticsearch::newrelic' do
  let(:chef_run) { runner.converge(described_recipe) }

  context 'when there is an api key' do
    let(:runner) { ChefSpec::Runner.new { |node|
      node.set['elasticsearch']['newrelic']['api_key'] = 'i bought this already'
      node.set['elasticsearch']['newrelic']['jar_url'] = 'http://example.com/newrelic.jar'
    } }

    it 'creates the newrelic parent directory' do
      expect(chef_run).to create_directory('/opt/local/newrelic')
    end

    it 'configures the license key for newrelic' do
      expect(chef_run).to render_file('/opt/local/newrelic/newrelic.yml').with_content(/^  license_key: 'i bought this already'$/)
    end

    it 'sets the app name' do
      expect(chef_run).to render_file('/opt/local/newrelic/newrelic.yml').with_content(/^  app_name: 'ElasticSearch'$/)
    end

    it 'creates an entry for the environment' do
      expect(chef_run).to render_file('/opt/local/newrelic/newrelic.yml').with_content(/^demo:$/)
    end

    it 'downloads the newrelic jar file' do
      expect(chef_run).to create_remote_file('/opt/local/newrelic/newrelic.jar').with(source: 'http://example.com/newrelic.jar')
    end
  end

  context 'when there is no api key' do
    let(:runner) { ChefSpec::Runner.new { |node|
      node.set['elasticsearch']['newrelic']['jar_url'] = 'http://example.com/newrelic.jar'
    } }

    it 'does not render the newrelic file' do
      expect(chef_run).not_to render_file('/opt/local/newrelic/newrelic.yml')
    end

    it 'does not download the newrelic jar file' do
      expect(chef_run).not_to create_remote_file('/opt/local/newrelic/newrelic.jar')
    end
  end
end
