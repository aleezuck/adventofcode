file = File.read("input.txt")
input = file.split("\n")

error_score = 0

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

  if newline.include?(")") || newline.include?("}") || newline.include?("]") || newline.include?(">")
    error = /(\(|\[|\{|\<)(\)|\]|\}|\>)/.match(newline)[2]
    case error
    when ")"
      error_score += 3
    when "]"
      error_score += 57
    when "}"
      error_score += 1197
    when ">"
      error_score += 25137
    end
  end
end

puts error_score
