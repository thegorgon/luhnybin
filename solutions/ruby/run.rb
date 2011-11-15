require File.expand_path("../lib.rb", __FILE__)

$stdin.each do |line|    
  $stdout.puts mask(line)
  $stdout.flush
end