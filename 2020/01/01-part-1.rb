file = File.read("input.txt")
input = file.split("\n").map { |x| x.to_i }

input.each do |num|
  target = 2020 - num

  if input.include?(target)
    puts num * target
    break
  end
end
