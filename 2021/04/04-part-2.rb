file = File.read("input.txt")
input = file.split("\n\n")
numbers = input[0].split(",").map { |x| x.to_i }
boards = input[1..-1].map { |x| x.split("\n") }

boards.each do |board|
  board.map! do |row|
    row.split.map { |x| x.to_i } 
  end
end

def check_bingo(board)
  return true if board[0][0] == "X" && board[0][1] == "X" && board[0][2] == "X" && board[0][3] == "X" && board[0][4] == "X"
  return true if board[1][0] == "X" && board[1][1] == "X" && board[1][2] == "X" && board[1][3] == "X" && board[1][4] == "X"
  return true if board[2][0] == "X" && board[2][1] == "X" && board[2][2] == "X" && board[2][3] == "X" && board[2][4] == "X"
  return true if board[3][0] == "X" && board[3][1] == "X" && board[3][2] == "X" && board[3][3] == "X" && board[3][4] == "X"
  return true if board[4][0] == "X" && board[4][1] == "X" && board[4][2] == "X" && board[4][3] == "X" && board[4][4] == "X"

  return true if board[0][0] == "X" && board[1][0] == "X" && board[2][0] == "X" && board[3][0] == "X" && board[4][0] == "X"
  return true if board[0][1] == "X" && board[1][1] == "X" && board[2][1] == "X" && board[3][1] == "X" && board[4][1] == "X"
  return true if board[0][2] == "X" && board[1][2] == "X" && board[2][2] == "X" && board[3][2] == "X" && board[4][2] == "X"
  return true if board[0][3] == "X" && board[1][3] == "X" && board[2][3] == "X" && board[3][3] == "X" && board[4][3] == "X"
  return true if board[0][4] == "X" && board[1][4] == "X" && board[2][4] == "X" && board[3][4] == "X" && board[4][4] == "X"

  return false
end

bingo = nil
winning_boards = []
total = boards.length

numbers.each_with_index do |num, index|
  boards.each do |board|
    board.each do |row|
      row.map! do |char|
        if char == num
          "X"
        else
          char
        end
      end
    end
  end
  
  boards.each_with_index do |board, index|
    if check_bingo(board)
      winning_boards << index
      winning_boards.uniq!
      leftover_nums = board.flatten.select { |x| x != "X" }
      bingo = num * leftover_nums.sum
      break if winning_boards.length == total
    end
  end

  break if winning_boards.length == total
end

puts bingo
