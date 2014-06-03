require 'spec_helper'

describe 'elasticsearch::default' do
  before do
    Chef::Recipe.any_instance.stub(:include_recipe)
  end

  it 'includes the configure recipe' do
    Chef::Recipe.any_instance.should_receive(:include_recipe).with('elasticsearch::configure')
    ChefSpec::Runner.new.converge(described_recipe)
  end

  it 'includes the install recipe' do
    Chef::Recipe.any_instance.should_receive(:include_recipe).with('elasticsearch::install')
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
