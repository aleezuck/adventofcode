file = File.read("input.txt")
input = file.split("\n").map { |x| x.split(/(\(contains\s|\))/) }

foods = []
all_ingredients = []
all_allergens = []

input.each do |string|
  arr = {}
  arr["ingredients"] = string[0].split
  all_ingredients << arr["ingredients"]
  arr["allergens"] = string[2].split(", ")
  all_allergens << arr["allergens"]
  foods << arr
end

all_allergens.flatten!.uniq!

allergen_hash = {}

all_allergens.each do |allergen|
  arr = []
  foods.each do |food|
    if food["allergens"].include?(allergen)
      arr << food["ingredients"]
    end
  end
  new_arr = arr.flatten.select { |x| arr.flatten.count(x) == arr.length }
  allergen_hash[allergen] = new_arr.uniq
end

count = 0

all_ingredients.flatten.each do |ing|
  count += 1 unless allergen_hash.values.flatten.include?(ing)
end

puts count
