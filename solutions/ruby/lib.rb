require 'fileutils'
require 'set'

class NumberMask 
  MASKED_DIGIT = "X"
  MIN_LENGTH = 14
  MAX_LENGTH = 16
  
  def initialize(string="")
    @input = string
    @characters = @input.split('')
  end
  
  def masked
    unless @masked
      @index = 0
      @mask = Set.new
      
      while (@index < @characters.length - 13) do
        char = @characters[@index]
        mask_number if char =~ /\d/
        @index += 1
      end
      
      @mask.each do |index|
        @characters[index] = MASKED_DIGIT
      end
      @masked = @characters.join('')
    end
    @masked
  end
  
  private
  
  def mask_number
    index = @index
    numbers = []
    number_indices = []
    
    loop do
      char = @characters[index]
      if char == '-' || char == ' '
        index += 1
      elsif char =~ /\d/
        numbers << char.to_i
        number_indices << index
        index += 1
                
        if cc_number?(numbers)
          @mask = @mask | number_indices
        end
        break if numbers.length == MAX_LENGTH
      else
        break
      end
    end
  end
  
  def cc_number?(numbers)
    valid_length?(numbers) && valid_luhn?(numbers)
  end
  
  def valid_length?(numbers)
    numbers.length >= MIN_LENGTH && numbers.length <= MAX_LENGTH
  end
  
  def valid_luhn?(array)
    sum = 0
    array.reverse.each_with_index do |num, idx|
      sum += idx.odd?? (num * 2).to_s.split('').inject(0) { |memo, x| memo += x.to_i } : num
    end
    sum.modulo(10) == 0
  end
end
