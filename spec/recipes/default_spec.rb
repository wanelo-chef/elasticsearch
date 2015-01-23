require 'spec_helper'

describe 'elasticsearch::default' do
  before do
    allow_any_instance_of(Chef::Recipe).to receive(:include_recipe)
  end

  it 'includes the configure recipe' do
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('elasticsearch::configure')
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it 'includes the install recipe' do
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('elasticsearch::install')
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it 'includes the log_rotation recipe' do
    expect_any_instance_of(Chef::Recipe).to receive(:include_recipe).with('elasticsearch::log_rotation')
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end
end
