file = File.read("input.txt")
input = file.split(",").map { |x| x.to_i }

lanternfish = Hash.new(0)

input.each do |num|
  lanternfish[num] += 1
end

80.times do
  new_hash = Hash.new(0)
  lanternfish.each do |num, amount|
    if num == 0
      new_hash[8] += amount
      new_hash[6] += amount
    elsif (1..8).include?(num)
      new_hash[num-1] += amount
    end
  end
  lanternfish = new_hash
end

puts lanternfish.values.sum
