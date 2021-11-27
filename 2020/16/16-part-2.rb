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

valid_tickets = []

other_tickets.each do |ticket|
  valid = true

  ticket.each do |num|
    unless rules_hash.values.flatten.include?(num)
      valid = false
      break
    end
  end

  valid_tickets << ticket if valid
end

my_ticket_hash = {}

until my_ticket_hash.keys.count == rules_hash.keys.count do
  # loop through each ticket index
  my_ticket.each_with_index do |num, index|
    # we want to find an index where only one rule is valid
    valid_rules = 0
    correct_key = ""

    # loop through all rules to check which are valid at this index
    rules_hash.each do |key, value|
      # skip rule if it's already been found for another index
      next if my_ticket_hash.key?(key)

      is_valid = true
      # compare that rule to all valid tickets
      valid_tickets.each do |ticket|
        # can't be correct rule if isn't in hash value
        is_valid = false unless value.include?(ticket[index])
      end
      
      if is_valid == true
        valid_rules += 1
        correct_key = key
      end
    end

    my_ticket_hash[correct_key] = num if valid_rules == 1
  end
end

puts my_ticket_hash["departure location"] * my_ticket_hash["departure track"] * my_ticket_hash["departure platform"] * my_ticket_hash["departure date"] * my_ticket_hash["departure station"] * my_ticket_hash["departure time"]
