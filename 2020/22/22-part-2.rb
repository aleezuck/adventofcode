file = File.read("input.txt")
input = file.split("\n\n")

player_1 = input[0].split("\n")
player_1.shift
player_1.map! { |x| x.to_i }
player_2 = input[1].split("\n")
player_2.shift
player_2.map! { |x| x.to_i }

def play_game(player_1, player_2)
  winning_hand = nil
  all_hands = []

  until player_1.empty? || player_2.empty?
    hand = [player_1.dup, player_2.dup]
    
    if all_hands.include?(hand)
      winning_hand = player_1
      break
    end

    all_hands << hand
    card_1 = player_1.shift
    card_2 = player_2.shift

    if card_1 <= player_1.length && card_2 <= player_2.length
      sub_player_1 = player_1[0..card_1-1]
      sub_player_2 = player_2[0..card_2-1]
      
      play_game(sub_player_1, sub_player_2)

      if sub_player_1.empty?
        player_2 << card_2
        player_2 << card_1
      elsif sub_player_2.empty?
        player_1 << card_1
        player_1 << card_2
      else
        player_1 << card_1
        player_1 << card_2
      end

    elsif card_1 > card_2
      player_1 << card_1
      player_1 << card_2
    elsif card_2 > card_1
      player_2 << card_2
      player_2 << card_1
    end

    if player_1.empty?
      winning_hand = player_2
    elsif player_2.empty?
      winning_hand = player_1
    end
  end

  return winning_hand
end

winning_hand = play_game(player_1, player_2)

score = 0
value = winning_hand.length

winning_hand.each do |card|
  score += card * value
  value -= 1
end

puts score
