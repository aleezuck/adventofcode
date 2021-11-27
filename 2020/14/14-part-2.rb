file = File.read("input.txt")
input = file.split("\n")

# convert decimal to binary string
def dec_to_bin(integer)
  binary = ""
  remainder = integer

  for i in 35.downto(0)
    if remainder >= 2**i
      binary << "1"
      remainder -= 2**i
    else
      binary << "0"
    end
  end

  return binary
end

def bin_to_dec(string)
  decimal = 0
  exponent = 35

  string.chars.each do |char|
    if char == "1"
      decimal += 2**exponent
    end
    exponent -= 1
  end

  return decimal
end

def apply_mask(string, mask)
  addresses = [string]
  new_address = ""
  new_addresses = []

  mask.chars.each_with_index do |char, index|
    addresses.each do |address|
      if char == "1"
        address[index] = "1"
      elsif char == "X"
        address[index] = "0"
        new_address = address.dup
        new_address[index] = "1"
        new_addresses << new_address
      end
    end
    addresses << new_addresses
    addresses.flatten!
    new_addresses = []
  end

  return addresses
end

mem = {}
mask = ""

input.each do |string|
  if string[0..3] == "mask"
    mask = string [7..-1]
  else
    match = /mem\[(?<key>\d+)\]\s=\s(?<val>\d+)/.match(string)
    addresses = apply_mask(dec_to_bin(match[:key].to_i), mask)
    keys = addresses.map { |address| bin_to_dec(address) }
    keys.each do |key|
      mem[key] = match[:val].to_i
    end
  end
end

puts mem.values.sum
