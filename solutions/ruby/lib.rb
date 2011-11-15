require 'fileutils'

class Masker 
  MASKED_DIGIT = "X"
  MIN_LENGTH = 14
  MAX_LENGTH = 16
  
  def initialize(string)
    @input = string
    @characters = @input.split('')
  end
  
  def masked
    unless @masked
      @masked = ""
      @index = 0
      while (@index < @characters.length) do
        char = @characters[@index]

        if char =~ /\d/ && number = mask_number
          masked << number
        else
          masked << @characters[@index]
          @index += 1
        end
      end
    end
    @masked
  end
  
  private
  
  def mask_number
    index = @index
    masked = ""
    numbers = []

    loop do
      char = @characters[index]
      if char == '-' || char == ' '
        masked << char
        index += 1
      elsif char =~ /\d/
        if cc_number?(numbers) && !cc_number?(numbers + [char.to_i])
          @index = index
          break
        else
          numbers << char.to_i
          masked << MASKED_DIGIT
          index += 1
        end
      else
        @index = index if cc_number?(numbers)
        break
      end
    end

    @index == index && masked
  end
  
  def cc_number?(numbers)
    numbers.length >= MIN_LENGTH && numbers.length <= MAX_LENGTH && valid_luhn?(numbers)
  end
  
  def valid_luhn?(array)
    sum = 0
    array.reverse.each_with_index do |num, idx|
      sum += idx.odd?? (num * 2).to_s.split('').inject(0) { |memo, x| memo += x.to_i } : num
    end
    sum.modulo(10) == 0
  end
end
