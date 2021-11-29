file = File.read("input.txt")
input = file.split("\n")

def math(string)
  terms = string.split(" ")
  
  # perform all additions first
  while terms.include?("+")
    new_terms = []
    add_index = terms.find_index("+")
    new_terms << terms[0..add_index-2] unless add_index == 1
    new_terms << terms[add_index - 1].to_i + terms[add_index + 1].to_i
    new_terms << terms[add_index+2..-1] unless add_index + 2 == terms.length
    new_terms.flatten!
    terms = new_terms
  end

  terms.select! { |x| x != "*" }
  terms.map! { |x| x.to_i }

  return terms.reduce(:*)
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
