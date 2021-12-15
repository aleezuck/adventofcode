file = File.read("input.txt")
input = file.split("").map { |x| x.to_i }

100.times do
  current_cup = input[0]
  current_index = input.index(current_cup)

  pick_up = input.slice!((current_index+1)..(current_index+3))
  destination = current_cup - 1
  destination = 9 if destination == 0

  until !pick_up.include?(destination)
    destination -= 1
    destination = 9 if destination == 0
  end

  destination_index = input.index(destination) + 1

  input.insert(destination_index, *pick_up)
  input.rotate!
end

until input[0] == 1
  input.rotate!
end

puts input[1..-1].join
