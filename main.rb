@numbers ||= []
@solved = false
@size ||= 0
@solution ||= {}

def init_size
  puts "Tell me about the size of your clock"
  STDOUT.flush
  @size = gets.chomp.to_i
  raise "Invalid size #{@size}" unless @size >= 0
end

def init_numbers
  @size.times do |i|
    puts "Tell me about the numbers on your clock #{i}"
    STDOUT.flush
    number = gets.chomp.to_i
    raise "Number must in [1-6]." unless (1..6).include?(number)
    @numbers << number
  end
end

def solve numbers, position
  unless @solved
    step = numbers[position].to_i
    to_left_position, to_left_value = abs_position(position + step), numbers[abs_position(position + step)]
    to_right_position, to_right_value = abs_position(position - step), numbers[abs_position(position - step)]

    @solution[position] = numbers.inspect.to_s

    numbers[position] = nil

    unless to_left_value.nil?
      solve numbers.dup, to_left_position
    end

    unless to_right_value.nil?
      solve numbers.dup, to_right_position
    end

    if numbers.compact.empty?
      @solved = true
    end
  end
end

def processing
  (0..@size-1).each do |i|
    numbers = @numbers.dup
    solve numbers, i
  end
end

def abs_position position
  if position < 0
    position = @size + position
  end
  position
end

init_size

init_numbers

processing

if @solved
  puts "Yeah, puzzle solved!"
  @solution.invert.sort.each { |e| puts e.last }
else
  puts "Sorry, I can not solve this puzzle."
end