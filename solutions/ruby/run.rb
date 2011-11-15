require File.expand_path("../lib.rb", __FILE__)

$stdin.each do |line|
  characters = line.split('')
  masked = ""

  loop do
    if characters.first =~ /\d/
      masked << mask_number(characters)
    elsif characters.first
      masked << characters.shift
    else
      break
    end
  end
  
  $stdout.puts masked
  $stdout.flush
end