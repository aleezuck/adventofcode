require 'json'

file = File.read("input.txt")
input = file.split("\n").map { |x| JSON.parse(x) }

def explode(arr)
  string = arr.to_json

  open_brackets = 0

  string.chars.each_with_index do |char, index|
    if char == "["
      open_brackets += 1
    elsif char == "]"
      open_brackets -= 1
    elsif open_brackets == 5
      match = /(\d+),(\d+)/.match(string[index..-1])
      l = match[1].to_i
      r = match[2].to_i

      if /(\d+)(\D+)$/.match(string[0..index-1])
        l += /(\d+)(\D+)$/.match(string[0..index-1])[1].to_i
        left_string = string[0..index-2].reverse.sub(/(\d+)/, l.to_s.reverse).reverse
      else
        left_string = string[0..index-2]
      end

      if /(\d+)/.match(string[(index+match[0].length)..-1])
        r += /(\d+)/.match(string[(index+match[0].length)..-1])[1].to_i
        right_string = string[(index+1+match[0].length)..-1].sub(/(\d+)/, r.to_s)
      else
        right_string = string[(index+1+match[0].length)..-1]
      end

      new_string = "#{left_string}0#{right_string}"
      return JSON.parse(new_string)
    end
  end

  return arr
end

def split(arr)
  val = arr.flatten.find { |x| x >= 10 }

  if val.nil?
    return arr
  end

  if val.even?
    new_val = [val/2, val/2]
  else
    new_val = [(val-1)/2, (val+1)/2]
  end

  string = arr.to_json
  new_string = string.sub(/#{val}/, new_val.to_json)

  return JSON.parse(new_string)
end

def add(arr1, arr2)
  add_arr = [arr1, arr2]

  loop do
    loop do
      new_arr = explode(add_arr)
      break if new_arr == add_arr
      add_arr = new_arr
    end

    new_arr = split(add_arr)
    break if new_arr == add_arr
    add_arr = new_arr
  end

  return add_arr
end

def magnitude(arr)
  string = arr.to_json
  regex = /\[(\d+),(\d+)\]/

  loop do
    break if regex.match(string) == nil
    left = regex.match(string)[1].to_i
    right = regex.match(string)[2].to_i

    val = 3*left + 2*right

    string.sub!(regex, val.to_s)
  end
  
  return string
end

magnitude = 0

input.permutation(2).to_a.each do |arr|
  number = add(arr[0], arr[1])
  number_mag = magnitude(number)
  magnitude = number_mag if number_mag.to_i > magnitude.to_i
end

puts magnitude
