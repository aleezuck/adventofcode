file = File.read("input.txt")
input = file.split("\n")

def program_result(array)
  index = 0
  accumulator = 0
  array_copy = array.dup
  status = nil

  until status
    instruction = array_copy[index]

    if instruction == "DONE"
      status = "looping"
    elsif index >= array_copy.length
      status = "finishes"
    else
      array_copy[index] = "DONE"
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

  # returns hash { "status" => accumulator }
  return { status => accumulator }
end

input.each_with_index do |x, index|
  if x[0..2] != "acc"
    test_input = input.dup
    if x[0..2] == "jmp"
      test_input[index] = "nop" + x[3..-1]
    elsif x[0..2] == "nop"
      test_input[index] = "jmp" + x[3..-1]
    end
    
    # code from part 1, see if it loops or finishes
    result = program_result(test_input)

    if result["finishes"]
      puts result["finishes"]
    end
  end
end
