require 'spec_helper'

describe 'elasticsearch::memory' do
  let(:runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { runner.converge(described_recipe) }

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

  context 'with dynamic_heap_ratio' do
    let(:runner) { ChefSpec::SoloRunner.new { |node|
        node.set['elasticsearch']['dynamic_heap_ratio'] = 0.9
    } }

    it 'sets min_heap to ratio of available memory' do
      expect(chef_run.node['elasticsearch']['min_heap']).to eq('921m')
    end

    it 'sets max_heap to ratio of available memory' do
      expect(chef_run.node['elasticsearch']['min_heap']).to eq('921m')
    end
  end
end
