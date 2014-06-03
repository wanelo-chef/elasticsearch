require 'spec_helper'

describe 'elasticsearch::memory' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  describe 'default[elasticsearch][min_heap]' do
    it 'returns a value' do
      expect(chef_run.node['elasticsearch']['min_heap']).to eq('512m')
    end
  end

  describe 'default[elasticsearch][max_heap]' do
    it 'returns a value' do
      expect(chef_run.node['elasticsearch']['max_heap']).to eq('512m')
    end
  end
end
