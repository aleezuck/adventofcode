file = File.read("input.txt")
input = file.split("\n")

bag_hash = {}

input.each do |string|
  regexp = /(?<outer_bag>[\w\s]+)(\sbags\scontain\s)(?<inner_bag>[\w\s,]+)/

  outer_bag = regexp.match(string)[:outer_bag]
  inner_bag = regexp.match(string)[:inner_bag].split(", ")

  inner_hash = {}

  unless inner_bag.first == "no other bags"
    inner_bag.each do |bag|
      match = /(?<num>\d)\s(?<color>[\w\s]+)\sbag/.match(bag)
      inner_hash[match[:color]] = match[:num].to_i
    end
  end

  bag_hash[outer_bag] = inner_hash
end

def count_bags(color, hash)
  count = 0
  hash[color].each do |color, value|
    if hash[color].empty?
      count += value
    else
      count += value + value * count_bags(color, hash)
    end
  end

  return count
end

puts count_bags("shiny gold", bag_hash)
