file = File.read("input.txt")
input = file.split("\n")

incomplete_lines = []

input.each do |line|
  newline = ""
  loop do
    newline = line.gsub(/\(\)|\[\]|\{\}|\<\>/, "")
    if newline.length == line.length
      break
    else
      line = newline
    end
  end

  unless newline.include?(")") || newline.include?("}") || newline.include?("]") || newline.include?(">")
    incomplete_lines << newline
  end
end

incomplete_lines.map! do |line|
  line.gsub!("(", ")")
  line.gsub!("[", "]")
  line.gsub!("{", "}")
  line.gsub!("<", ">")
  line.reverse
end

scores = []

incomplete_lines.each do |line|
  score = 0
  line.chars.each do |char|
    score *= 5
    case char
    when ")"
      score += 1
    when "]"
      score += 2
    when "}"
      score += 3
    when ">"
      score += 4
    end
  end
  scores << score
end

scores.sort!

puts scores[(scores.length-1)/2]
