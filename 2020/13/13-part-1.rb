file = File.read("input.txt")
input = file.split("\n")

timestamp = input[0].to_i

bus_ids = input[1].split(",")

lowest_id = 0
lowest_time = timestamp

bus_ids.each do |id|
  unless id == "x"
    current_id = id.to_i
    current_time = id.to_i - timestamp % id.to_i
    if current_time < lowest_time
      lowest_time = current_time
      lowest_id = current_id
    end
  end
end

puts lowest_id * lowest_time
