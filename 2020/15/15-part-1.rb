file = File.read("input.txt")
input = file.split(",").map { |x| x.to_i }

turn = 1
num_hash = {}
num = 0

input.each do |i|
  num_hash[i] = turn
  turn += 1
end

until turn == 2020
  if num_hash.key?(num)
    new_num = turn - num_hash[num]
  else
    new_num = 0
  end

  num_hash[num] = turn
  num = new_num
  turn += 1
end

puts num
