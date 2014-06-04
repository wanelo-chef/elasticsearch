module CpuHelper
  def number_of_processors
    case node['platform']
      when 'smartos'
        `sm-cpuinfo  | grep Alloc | cut -f 2 -d':'`.chomp.to_i
      when 'darwin'
        `sysctl hw.ncpu | awk '{print $2}'`.chomp.to_i
      when 'chefspec'
        1
      else
        `cat /proc/cpuinfo | grep "^processor" | wc -l`.chomp.to_i
    end
  end
end
