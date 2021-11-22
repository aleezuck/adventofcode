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
  if required.all? { |key| passport.key?(key) }
    is_valid = true

    # byr (Birth Year) - four digits; at least 1920 and at most 2002.
    is_valid = false if passport["byr"].to_i < 1920 || passport["byr"].to_i > 2002

    # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    is_valid = false if passport["iyr"].to_i < 2010 || passport["iyr"].to_i > 2020

    # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    is_valid = false if passport["eyr"].to_i < 2020 || passport["eyr"].to_i > 2030

    # hgt (Height) - a number followed by either cm or in:
      # If cm, the number must be at least 150 and at most 193.
      # If in, the number must be at least 59 and at most 76.
    if passport["hgt"].end_with?("cm")
      height = passport["hgt"][0..-2].to_i
      is_valid = false if height < 150 || height > 193
    elsif passport["hgt"].end_with?("in")
      height = passport["hgt"][0..-2].to_i
      is_valid = false if height < 59 || height > 76
    else
      is_valid = false
    end

    # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    if passport["hcl"].start_with?("#") && passport["hcl"].length == 7
      range = [("a".."f").to_a, ("0".."9").to_a].flatten
      is_valid = false unless passport["hcl"][1..7].chars.all? { |char| range.include?(char) }
    else
      is_valid = false
    end

    # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    is_valid = false unless %w[amb blu brn gry grn hzl oth].include?(passport["ecl"])

    # pid (Passport ID) - a nine-digit number, including leading zeroes.
    is_valid = false unless passport["pid"].length == 9

    valid += 1 if is_valid
  end
end

puts valid
