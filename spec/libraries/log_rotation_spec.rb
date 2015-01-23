require 'spec_helper'
require File.expand_path('../../../libraries/log_rotation', __FILE__)

describe Elasticsearch::Helper::LogRotation do
  let(:log_rotation_attrs) { {} }
  let(:node) { {'elasticsearch' => {'log_rotation' => log_rotation_attrs}} }
  subject(:helper) { Elasticsearch::Helper::LogRotation.new(node) }

  describe '#rotate_logs?' do
    context 'rotation_dir is set' do
      let(:log_rotation_attrs) { { 'rotation_dir' => '/dir' } }
      it 'is true' do
        expect(helper.rotate_logs?).to be true
      end
    end

    context 'rotation_dir is not set' do
      let(:log_rotation_attrs) { { 'rotation_dir' => nil } }
      it 'is false' do
        expect(helper.rotate_logs?).to be false
      end
    end
  end

  describe '#cron' do
    let(:log_rotation_attrs) { {'rotation_dir' => '/dir'} }
    it 'formats command with node attributes' do
      expect(helper.cron).to eq(
        'find /var/log/elasticsearch -name "*.log.*" -print0 | xargs -0 -n 1 -P 5 -I% rsync -a % /dir'
      )
    end
  end
end

