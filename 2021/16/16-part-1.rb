file = File.read("input.txt")
input = file.split("")

HEX_TO_BIN = {
  "0" => "0000",
  "1" => "0001",
  "2" => "0010",
  "3" => "0011",
  "4" => "0100",
  "5" => "0101",
  "6" => "0110",
  "7" => "0111",
  "8" => "1000",
  "9" => "1001",
  "A" => "1010",
  "B" => "1011",
  "C" => "1100",
  "D" => "1101",
  "E" => "1110",
  "F" => "1111",
}

hex_input = ""

input.each do |char|
  hex_input << HEX_TO_BIN[char]
end

def parse_packet(string)
  packet = {}

  packet[:packet_version] = HEX_TO_BIN.key("0" + string.slice!(0..2))

  packet[:packet_type] = HEX_TO_BIN.key("0" + string.slice!(0..2))
  
  packet[:bit_length] = 6

  if packet[:packet_type] == "4"
    bin_value = ""
    loop do
      bits = string.slice!(0..4)
      bin_value << bits[1..4]
      packet[:bit_length] += 5
      break if bits[0] == "0"
    end
    packet[:value] = bin_value.to_i(2)
  else
    packet[:length_type] = string.slice!(0)
    packet[:bit_length] += 1

    packet[:sub_packets] = []
  
    if packet[:length_type] == "0"
      length = string.slice!(0..14).to_i(2)
      packet[:bit_length] += 15
      read_length = 0
      
      loop do
        new_packet = parse_packet(string)
        packet[:sub_packets] << new_packet

        read_length += packet[:sub_packets].last[:bit_length]
        packet[:bit_length] += packet[:sub_packets].last[:bit_length]

        if read_length >= length
          break
        end
      end
    else
      length = string.slice!(0..10).to_i(2)
      packet[:bit_length] += 11

      until packet[:sub_packets].count >= length
        packet[:sub_packets] << parse_packet(string)
        packet[:bit_length] += packet[:sub_packets].last[:bit_length]
      end
    end
  end

  return packet
end

transmission = parse_packet(hex_input)

def version_sum(transmission)
  sum = 0
  
  sum += transmission[:packet_version].to_i

  if transmission[:sub_packets]
    transmission[:sub_packets].each do |sub|
      sum += version_sum(sub)
    end
  end

  return sum
end

puts version_sum(transmission)
