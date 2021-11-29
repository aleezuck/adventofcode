file = File.read("input.txt")
input = file.split("\n")

def math(string)
  terms = string.split(" ")
  result = terms[0].to_i
  operator = terms[1]

  i = 0
  terms.each do |term|
    i += 1
    next if i <= 2

    if term == "+" || term == "*"
      operator = term
    else
      if operator == "+"
        result += term.to_i
      elsif operator == "*"
        result *= term.to_i
      end
    end
  end

  return result
end

results = input.map do |string|
  loop do
    new_string = string.gsub(/\(([\*\+\d\s]+)\)/) { |match| math($1) }
    break if new_string == string
    string = new_string
  end

  math(string)
end

puts results.sum
