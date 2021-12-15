file = File.read("input.txt")
input = file.split("").map { |x| x.to_i }

input_hash = {}

input.each_cons(2) do |pair|
  input_hash[pair[0]] = pair[1]
end

last_val = input[-1]

for i in 10..1_000_000
  input_hash[last_val] = i
  last_val = i
end

input_hash[last_val] = input[0]
max_val = 1_000_000
current_cup = input[0]

10_000_000.times do
  pick_1 = input_hash[current_cup]
  pick_2 = input_hash[pick_1]
  pick_3 = input_hash[pick_2]
  
  destination = current_cup - 1
  destination = max_val if destination == 0

  until ![pick_1, pick_2, pick_3].include?(destination)
    destination -= 1
    destination = max_val if destination == 0
  end

  destination_after = input_hash[destination]
  
  input_hash[current_cup] = input_hash[pick_3]
  input_hash[destination] = pick_1
  input_hash[pick_3] = destination_after

  current_cup = input_hash[current_cup]
end

puts input_hash[1] * input_hash[input_hash[1]]
