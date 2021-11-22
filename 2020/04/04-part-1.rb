file = File.read("input.txt")
input = file.split("\n\n")

passport_array = input.map do |passport|
  hash = {}
  arr = passport.split(" ")

  arr.each do |item|
    field = item.split(":")
    hash[field.first] = field.last
  end

  hash
end

valid = 0
required = %w[byr iyr eyr hgt hcl ecl pid]

passport_array.each do |passport|
  valid +=1 if required.all? { |key| passport.key?(key) }
end

puts valid
