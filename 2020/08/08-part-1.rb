file = File.read("input.txt")
input = file.split("\n")

index = 0
accumulator = 0
looping = false

until looping
  instruction = input[index]

  if instruction == "DONE"
    looping = true
  else
    input[index] = "DONE"
    operation = instruction[0..2]
    argument = instruction[5..-1].to_i
    argument = -argument if instruction[4] == "-"

    case operation
    when "nop"
      index += 1
    when "acc"
      index += 1
      accumulator += argument
    when "jmp"
      index += argument
    end
  end
end

puts accumulator
