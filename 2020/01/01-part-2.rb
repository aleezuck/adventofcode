file = File.read("input.txt")
input = file.split("\n").map { |x| x.to_i }

combinations = input.combination(3).to_a

combinations.each do |combo|
  if combo.sum == 2020
    puts combo.reduce(:*)
    break
  end
end
