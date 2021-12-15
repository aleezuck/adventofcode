file = File.read("input.txt")
input = file.split("\n\n")

player_1 = input[0].split("\n")
player_1.shift
player_1.map! { |x| x.to_i }
player_2 = input[1].split("\n")
player_2.shift
player_2.map! { |x| x.to_i }
winning_hand = nil

loop do
  card_1 = player_1.shift
  card_2 = player_2.shift

  if card_1 > card_2
    player_1 << card_1
    player_1 << card_2
  elsif card_2 > card_1
    player_2 << card_2
    player_2 << card_1
  end

  if player_1.length == 0
    winning_hand = player_2
    break
  elsif player_2.length == 0
    winning_hand = player_1
    break
  end
end

score = 0
value = winning_hand.length

winning_hand.each do |card|
  score += card * value
  value -= 1
end

puts score
