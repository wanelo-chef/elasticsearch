require 'spec_helper'

describe 'elasticsearch::install' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs elasticsearch' do
    expect(chef_run).to install_package('elasticsearch')
  end

  describe 'package[elasticsearch]' do
    let(:resource) { chef_run.package('elasticsearch') }

    it 'enables elasticsearch' do
      expect(resource).to notify('service[elasticsearch]').to(:enable)
    end

    it 'starts elasticsearch' do
      expect(resource).to notify('service[elasticsearch]').to(:start)
    end
  end
end
