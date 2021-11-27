file = File.read("input.txt")
input = file.split("\n")

rules = []
my_ticket = []
other_tickets = []
# section -> 1 is rules, 2 is my ticket, 3 is nearby tickets
section = 1

input.each do |row|
  case section
  when 1
    rules << row
    section +=1 if row == ""
  when 2
    my_ticket << row
    section +=1 if row == ""
  when 3
    other_tickets << row
  end
end

rules.pop
my_ticket.pop
my_ticket.shift
other_tickets.shift

my_ticket = my_ticket[0].split(",").map { |x| x.to_i }
other_tickets.map! { |ticket| ticket.split(",").map { |x| x.to_i } }

rules_hash = {}
rules.each do |rule|
  match = /(?<field>[\w\s]+):\s(?<range_1>\d+-\d+)\sor\s(?<range_2>\d+-\d+)/.match(rule)
  field = match[:field]
  keys = []
  range_1 = match[:range_1].split("-")
  range_2 = match[:range_2].split("-")
  keys << (range_1.first.to_i..range_1.last.to_i).to_a
  keys << (range_2.first.to_i..range_2.last.to_i).to_a
  rules_hash[field] = keys.flatten
end

ticket_error = []

other_tickets.each do |ticket|
  ticket.each do |num|
    ticket_error << num unless rules_hash.values.flatten.include?(num)
  end
end

puts ticket_error.sum
