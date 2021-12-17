file = File.read("input.txt")
input = file.split("")

X_RANGE = 192..251
Y_RANGE = -89..-59

X_MAX = 251
Y_MIN = -89

def probe_steps(vel_x, vel_y)
  steps = []
  highest = false
  x = 0
  y = 0

  loop do
    x += vel_x
    y += vel_y

    steps << [x, y]

    vel_x -= 1 if vel_x > 0
    vel_y -= 1

    if X_RANGE.include?(x) && Y_RANGE.include?(y)
      highest = steps.max_by { |arr| arr[1] }[1]
    elsif y < Y_MIN
      break
    end
  end

  return highest
end

vel_hash = {}

for x in 1..200
  for y in 1..200
    vel_hash[[x, y]] = probe_steps(x, y)
  end
end

puts vel_hash.select { |k, v| v != false }.max_by{ |k, v| v }[1]
