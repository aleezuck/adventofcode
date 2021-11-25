file = File.read("input.txt")
input = file.split("\n")

bus_ids = input[1].split(",")

timestamp = 1

divisor = 1
increment = 1
offset = 0

bus_ids.each_with_index do |id, index|
  unless id == "x"
    offset = index
    divisor = id.to_i
    
    until (timestamp + offset) % divisor == 0
      timestamp += increment
    end

    # bus numbers are all prime -> next timestamp will be at multiple
    increment *= divisor
  end
end

puts timestamp
