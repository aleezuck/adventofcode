file = File.read("input.txt")
input = file.split("\n\n")
messages = input[1].split("\n")
rules = {}
finished_rules = []

input[0].split("\n").each do |string|
  match = /(?<key>\d+):\s(?<value>.+)/.match(string)
  if match[:value].start_with?("\"")
    rules[match[:key]] = [match[:value].gsub!("\"", "")]
  else
    rules[match[:key]] = [match[:value]]
  end
end

def apply_rules(subrule, rules_hash)
  values = []

  subrule.split(" | ").each do |half|
    new_subrule = []
    half.split(" ").each do |key|
      if key.start_with?(/\D/)
        new_subrule << apply_rules(rules_hash[key], rules_hash)
      elsif rules_hash[key].include?("|")
        new_subrule << key
      else
        new_subrule << rules_hash[key]
      end
    end
    if new_subrule.length == 1
      values << new_subrule
    else
      values << new_subrule[0].product(new_subrule[1]).map { |arr| arr.join }
    end
  end

  return values.flatten
end

until rules.keys.length == finished_rules.length
  rules.each do |key, value|
    # see if rule is written out in letter form
    if value.flatten[0].start_with?(/\D/)
      finished_rules << key
    end
    finished_rules.uniq!

    # check if subrules are finished
    if value.flatten[0].split(/[\s\|\s|\s]/).reject { |item| item.empty? }.all? { |char| finished_rules.include?(char) }
      new_value = apply_rules(value[0], rules)
      rules[key] = new_value
    end
  end
end

message_count = 0

def check_rule(message, rule_number, rules_hash)
  rules_hash[rule_number].each do |rule|
    if message.start_with?(rule)
      message.slice!(rule)
      return message
    end
  end
  return false
end

# 0: 8 11
# 8: 42 | 42 8
# 11: 42 31 | 42 11 31
# (42 at least once more than 31) (31 at least once)

messages.each do |message|
  count_42 = 0
  count_31 = 0

  until check_rule(message, "42", rules) == false
    count_42 += 1
  end

  until check_rule(message, "31", rules) == false
    count_31 += 1
  end

  if count_42 >= count_31 + 1 && count_31 >= 1 && message.length == 0
    message_count += 1
  end
end

puts message_count
