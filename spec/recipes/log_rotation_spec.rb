require 'spec_helper'

describe 'elasticsearch::log_rotation' do
  let(:chef_run) { runner.converge(described_recipe) }
  let(:runner) { ChefSpec::SoloRunner.new { |node|
    node.set['elasticsearch']['log_rotation'] = {
      'rotation_dir' => rotation_dir
    }
  } }

  context 'with a rotation dir' do
    let(:rotation_dir) { '/path/to/rotated/logs' }
    it 'configures a rotation crontab' do
      expect(chef_run).to create_cron('rotate elasticsearch logs')
    end
  end

  context 'without a rotation dir' do
    let(:rotation_dir) { nil }
    it 'removes the rotation crontab' do
      expect(chef_run).to delete_cron('rotate elasticsearch logs')
    end
  end
end
