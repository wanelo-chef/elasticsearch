require 'spec_helper'

describe 'elasticsearch::plugins' do
  let(:runner) { ChefSpec::Runner.new }
  let(:chef_run) { runner.converge(described_recipe) }

  context 'when the plugin is already installed' do
    before do
      stub_command('JAVA_HOME=/opt/local/java/openjdk7 /opt/local/bin/plugin --list | grep HQ').and_return(true)
    end

    it 'does not install it a second time' do
      expect(chef_run).to_not run_execute('/opt/local/bin/plugin --install royrusso/elasticsearch-HQ')
    end
  end

  context 'when the plugin is not installed' do
    before do
      stub_command('JAVA_HOME=/opt/local/java/openjdk7 /opt/local/bin/plugin --list | grep HQ').and_return(false)
    end

    it 'installs the configured plugin' do
      expect(chef_run).to run_execute('/opt/local/bin/plugin --install royrusso/elasticsearch-HQ')
    end
  end
end
