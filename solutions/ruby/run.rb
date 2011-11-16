require File.expand_path("../lib.rb", __FILE__)

$stdin.each do |line|    
  $stdout.puts NumberMask.new(line).masked
  $stdout.flush
end