require 'spec_helper'

describe 'elasticsearch::install' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs elasticsearch' do
    expect(chef_run).to install_package('elasticsearch')
  end
end
