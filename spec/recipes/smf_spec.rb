require 'spec_helper'

describe 'elasticsearch::smf' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'deletes pkgsrc/elasticsearch' do
    expect(chef_run).to delete_smf('pkgsrc/elasticsearch')
  end

  it 'installs elasticsearch' do
    expect(chef_run).to install_smf('elasticsearch')
  end
end
