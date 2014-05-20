require 'spec_helper'

describe 'elasticsearch::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  before do
    # Don't worry about external cookbook dependencies
    Chef::Cookbook::Metadata.any_instance.stub(:depends)

    # Test each recipe in isolation, regardless of includes
    @included_recipes = []
    Chef::RunContext.any_instance.stub(:loaded_recipe?).and_return(false)
    Chef::Recipe.any_instance.stub(:include_recipe) do |i|
      Chef::RunContext.any_instance.stub(:loaded_recipe?).with(i).and_return(true)
      @included_recipes << i
    end
    Chef::RunContext.any_instance.stub(:loaded_recipes).and_return(@included_recipes)
  end

  it 'includes the configure recipe' do
    expect(chef_run).to include_recipe('elasticsearch::configure')
  end

  it 'includes the install recipe' do
    expect(chef_run).to include_recipe('elasticsearch::install')
  end
end
