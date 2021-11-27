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
  new_string = string

  mask.chars.each_with_index do |char, index|
    new_string[index] = char unless char == "X"
  end

  return new_string
end

mem = {}
mask = ""

input.each do |string|
  if string[0..3] == "mask"
    mask = string [7..-1]
  else
    match = /mem\[(?<key>\d+)\]\s=\s(?<val>\d+)/.match(string)
    num = dec_to_bin(match[:val].to_i)
    masked_num = apply_mask(num, mask)
    mem[match[:key].to_i] = bin_to_dec(masked_num)
  end
end

puts mem.values.sum
