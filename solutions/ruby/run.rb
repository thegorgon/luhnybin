require File.expand_path("../lib.rb", __FILE__)

$stdin.each do |line|    
  $stdout.puts Masker.new(line).masked
  $stdout.flush
end