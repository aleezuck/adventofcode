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
      inner_hash[match[:color]] = match[:num]
    end
  end

  bag_hash[outer_bag] = inner_hash
end

def check_for_gold?(bag_contents, bag_hash)
  gold = false
  
  if bag_contents.key?("shiny gold")
    gold = true
  elsif !bag_contents.empty?
    bag_contents.keys.each do |key|
      gold = check_for_gold?(bag_hash[key], bag_hash)
      break if gold
    end
  end
  
  # returns boolean, true if contains gold, false if not
  return gold
end

gold_bags = 0

bag_hash.each do |key, value|
  if check_for_gold?(value, bag_hash)
    gold_bags += 1
  end
end

puts gold_bags
