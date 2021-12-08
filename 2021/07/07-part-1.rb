file = File.read("input.txt")
input = file.split(",").map { |x| x.to_i }.sort!

range = input[0]..input[-1]
fuel = []

range.each do |num|
  total_fuel = 0
  input.each do |i|
    total_fuel += (i - num).abs
  end
  fuel << {num => total_fuel}
end

puts fuel.sort_by { |hash| hash.values }.first.values
