file = File.read("test-input.txt")
input = file.split("\n")

player_1 = 2
player_2 = 5

score_1 = 0
score_2 = 0

ROLLS = [1, 2, 3].product([1, 2, 3].product([1, 2, 3])).map { |x| x.flatten.sum }.tally

def play_game(player_1, player_2, score_1, score_2, turn)
  universes = 0

  if score_1 >= 21
    universes = 1
  elsif score_2 >= 21
    universes = 0
  else
    if turn % 2 == 0
      ROLLS.each do |k, v|
        move = (player_1 + k) % 10
        move = 10 if move == 0
        universes += play_game(move, player_2, score_1 + move, score_2, turn + 1) * v
      end
    else
      ROLLS.each do |k, v|
        move = (player_2 + k) % 10
        move = 10 if move == 0
        universes += play_game(player_1, move, score_1, score_2 + move, turn + 1) * v
      end
    end
  end

  return universes
end

puts play_game(player_1, player_2, score_1, score_2, 0)
