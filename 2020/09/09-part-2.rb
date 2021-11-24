file = File.read("input.txt")
input = file.split("\n").map { |x| x.to_i }

target = 85848519

input.each_with_index do |num, index|
  set = []
  sum = 0
  i = index

  until sum >= target
    set << input[i]
    sum += input[i]
    i += 1
  end

  if sum == target
    puts set.sort.first + set.sort.last
    break
  end
end
