require 'spec_helper'

describe 'elasticsearch::cpu' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  describe 'default[elasticsearch][processors]' do
    it 'returns a value' do
      expect(chef_run.node['elasticsearch']['processors']).to eq(1)
    end
  end
end
