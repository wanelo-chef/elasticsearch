module MemoryHelper
  def recommended_ram_mb
    heap_size = case node['platform']
                  when 'smartos'
                    `prtconf -m`.chomp.to_i
                  when 'darwin'
                    `sysctl -a | grep 'hw.memsize =' | sed 's/.* = //g'`.chomp.to_i / (1024 * 1024)
                  when 'chefspec'
                    1024
                  else
                    `free -m | grep Mem | awk '{print $2}'`.chomp.to_i
                end
    [30000, heap_size / 2].min
  end
end
