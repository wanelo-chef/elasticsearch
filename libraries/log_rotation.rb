BaseNodeHelper ||= Struct.new(:node)

module Elasticsearch
  module Helper
    class LogRotation < BaseNodeHelper
      def rotate_logs?
        !!node['elasticsearch']['log_rotation']['rotation_dir']
      end

      def cron
        format('find /var/log/elasticsearch -name "*.log.*" -print0 | xargs -0 -n 1 -P 5 -I%% rsync -a %% %s',
          node['elasticsearch']['log_rotation']['rotation_dir']
        )
      end
    end
  end
end
