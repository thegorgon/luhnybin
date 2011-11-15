require 'fileutils'

MASKED_DIGIT = "X"

def luhn_check(array)
  sum = 0
  array.reverse.each_with_index do |num, idx|
    sum += idx.odd?? (num * 2).to_s.split('').inject(0) { |memo, x| memo += x.to_i } : num
  end
  sum.modulo(10) == 0
end


def mask_number(number)
  masked = ""
  unmasked = ""
  numbers = []
  
  loop do
    char = number.shift
    if char == '-' || char == ' '
      masked << char
      unmasked << char
    elsif char =~ /\d/
      unmasked << char
      masked << MASKED_DIGIT
      numbers << char.to_i
    else
      break
    end
  end
  
  if numbers.length >= 14 && numbers.length <= 16 && luhn_check(numbers)
    masked
  else
    unmasked
  end
end

def mask(input)
  characters = input.split('')
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
  masked
end