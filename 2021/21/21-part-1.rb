file = File.read("test-input.txt")
input = file.split("\n")

player_1 = 2
player_2 = 5

score_1 = 0
score_2 = 0

die = 1

loop do
  move_1 = (die % 100) + ((die + 1) % 100) + ((die + 2) % 100)
  player_1 = (player_1 + move_1) % 10
  if player_1 == 0
    player_1 += 10
  end
  score_1 += player_1
  die += 3
  puts "player 1 score is #{score_1}"
  break if score_1 >= 1000

  move_2 = (die % 100) + ((die + 1) % 100) + ((die + 2) % 100)
  player_2 = (player_2 + move_2) % 10
  if player_2 == 0
    player_2 += 10
  end
  score_2 += player_2
  die += 3
  puts "player 2 score is #{score_2}"
  break if score_2 >= 1000
end

die -= 1

if score_1 >= 1000
  puts die * score_2
else
  puts die * score_1
end
