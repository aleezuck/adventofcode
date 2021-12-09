file = File.read("input.txt")
input = file.split("\n").map { |x| x.split(" | ") }

signals = []
output = []

input.each do |arr|
  output << arr[1].split(" ")
end

input.each do |arr|
  signal = {}
  signal_arr = arr[0].split(" ")

  signal_arr.each do |s|
    if s.length == 2
      signal[1] = s.split("").sort.join
    elsif s.length == 3
      signal[7] = s.split("").sort.join
    elsif s.length == 4
      signal[4] = s.split("").sort.join
    elsif s.length == 7
      signal[8] = s.split("").sort.join
    end
  end

  signal["a"] = (signal[7].split("") - signal[1].split(""))[0]

  length_6 = []

  signal_arr.each do |s|
    if s.length == 6
      length_6 << s
    end
  end

  length_6.map! { |x| (signal[8].split("") - x.split(""))[0] }

  signal["d"] = length_6.select { |x| (signal[4].split("") - signal[1].split("")).include?(x) }[0]
  signal["b"] = (signal[4].split("") - signal[1].split("") - [signal["d"]])[0]
  signal["e"] = length_6.select { |x| (signal[8].split("") - signal[4].split("")).include?(x) }[0]
  signal["g"] = (signal[8].split("") - signal[4].split("") - [signal["a"]] - [signal["e"]])[0]
  signal["c"] = (length_6 - [signal["d"]] - [signal["e"]])[0]
  signal["f"] = (signal[8].split("") - [signal["a"]] - [signal["b"]] - [signal["c"]] - [signal["d"]] - [signal["e"]] - [signal["g"]])[0]

  signal[0] = [signal["a"], signal["b"], signal["c"], signal["e"], signal["f"], signal["g"]].sort.join
  signal[2] = [signal["a"], signal["c"], signal["d"], signal["e"], signal["g"]].sort.join
  signal[3] = [signal["a"], signal["c"], signal["d"], signal["f"], signal["g"]].sort.join
  signal[5] = [signal["a"], signal["b"], signal["d"], signal["f"], signal["g"]].sort.join
  signal[6] = [signal["a"], signal["b"], signal["d"], signal["e"], signal["f"], signal["g"]].sort.join
  signal[9] = [signal["a"], signal["b"], signal["c"], signal["d"], signal["f"], signal["g"]].sort.join

  signals << signal
end

total = 0

output.each_with_index do |arr, index|
  signal = signals[index]
  num = ""
  arr.each do |string|
    num << signal.key(string.split("").sort.join).to_s
  end
  total += num.to_i
end

puts total
