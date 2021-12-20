file = File.read("input.txt")
input = file.split("\n\n").map { |x| x.split("\n") }

scanners = []

input.each do |arr|
  scanner = {}
  scanner[:beacons] = {}
  beacon_id = 0
  arr.each do |line|
    if line.start_with?("---")
      scanner[:id] = /\d+/.match(line)[0].to_i
    else
      coords = line.split(",").map { |x| x.to_i }
      scanner[:beacons][beacon_id] = { :x => coords[0], :y => coords[1], :z => coords[2] }
      beacon_id += 1
    end
  end
  scanners << scanner
end

scanners[0][:x] = 0
scanners[0][:y] = 0
scanners[0][:z] = 0

known_beacons = []

scanners[0][:beacons].each do |beacon|
  known_beacons << [beacon[1][:x], beacon[1][:y], beacon[1][:z]]
end

def check_overlap(known_beacons, scanner_beacons)
  known_combos = []
  known_beacons.combination(2).to_a.each do |combo|
    c = []
    c << combo[1][0] - combo[0][0]
    c << combo[1][1] - combo[0][1]
    c << combo[1][2] - combo[0][2]
    known_combos << c
  end
  
  matched = []

  scanner_beacons.each do |beacon|
    id = beacon[0]
    scanner_beacons.each do |beacon_2|
      next if beacon_2[0] == id
      dx = beacon_2[1][:x] - beacon[1][:x]
      dy = beacon_2[1][:y] - beacon[1][:y]
      dz = beacon_2[1][:z] - beacon[1][:z]
      if known_combos.include? [dx, dy, dz]
        matched << id
        matched << beacon_2[0]
        break
      end
    end
  end

  return matched.uniq
end

def get_rotations(beacon_hash)
  rotations = [beacon_hash]

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = beacon_hash[k][:x]
    new_hash[:y] = beacon_hash[k][:z]
    new_hash[:z] = -beacon_hash[k][:y]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = beacon_hash[k][:x]
    new_hash[:y] = -beacon_hash[k][:y]
    new_hash[:z] = -beacon_hash[k][:z]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = beacon_hash[k][:x]
    new_hash[:y] = -beacon_hash[k][:z]
    new_hash[:z] = beacon_hash[k][:y]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = -beacon_hash[k][:x]
    new_hash[:y] = -beacon_hash[k][:y]
    new_hash[:z] = beacon_hash[k][:z]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = -beacon_hash[k][:x]
    new_hash[:y] = -beacon_hash[k][:z]
    new_hash[:z] = -beacon_hash[k][:y]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = -beacon_hash[k][:x]
    new_hash[:y] = beacon_hash[k][:y]
    new_hash[:z] = -beacon_hash[k][:z]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = -beacon_hash[k][:x]
    new_hash[:y] = beacon_hash[k][:z]
    new_hash[:z] = beacon_hash[k][:y]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = -beacon_hash[k][:y]
    new_hash[:y] = beacon_hash[k][:x]
    new_hash[:z] = beacon_hash[k][:z]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = beacon_hash[k][:z]
    new_hash[:y] = beacon_hash[k][:x]
    new_hash[:z] = beacon_hash[k][:y]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = beacon_hash[k][:y]
    new_hash[:y] = beacon_hash[k][:x]
    new_hash[:z] = -beacon_hash[k][:z]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = -beacon_hash[k][:z]
    new_hash[:y] = beacon_hash[k][:x]
    new_hash[:z] = -beacon_hash[k][:y]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = beacon_hash[k][:y]
    new_hash[:y] = -beacon_hash[k][:x]
    new_hash[:z] = beacon_hash[k][:z]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = beacon_hash[k][:z]
    new_hash[:y] = -beacon_hash[k][:x]
    new_hash[:z] = -beacon_hash[k][:y]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = -beacon_hash[k][:y]
    new_hash[:y] = -beacon_hash[k][:x]
    new_hash[:z] = -beacon_hash[k][:z]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = -beacon_hash[k][:z]
    new_hash[:y] = -beacon_hash[k][:x]
    new_hash[:z] = beacon_hash[k][:y]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = -beacon_hash[k][:z]
    new_hash[:y] = beacon_hash[k][:y]
    new_hash[:z] = beacon_hash[k][:x]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = -beacon_hash[k][:y]
    new_hash[:y] = -beacon_hash[k][:z]
    new_hash[:z] = beacon_hash[k][:x]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = beacon_hash[k][:z]
    new_hash[:y] = -beacon_hash[k][:y]
    new_hash[:z] = beacon_hash[k][:x]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = beacon_hash[k][:y]
    new_hash[:y] = beacon_hash[k][:z]
    new_hash[:z] = beacon_hash[k][:x]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = beacon_hash[k][:z]
    new_hash[:y] = beacon_hash[k][:y]
    new_hash[:z] = -beacon_hash[k][:x]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = -beacon_hash[k][:y]
    new_hash[:y] = beacon_hash[k][:z]
    new_hash[:z] = -beacon_hash[k][:x]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = -beacon_hash[k][:z]
    new_hash[:y] = -beacon_hash[k][:y]
    new_hash[:z] = -beacon_hash[k][:x]
    [k, new_hash]
  end
  rotations << hash.to_h

  hash = beacon_hash.map do |k, v|
    new_hash = {}
    new_hash[:x] = beacon_hash[k][:y]
    new_hash[:y] = -beacon_hash[k][:z]
    new_hash[:z] = -beacon_hash[k][:x]
    [k, new_hash]
  end
  rotations << hash.to_h

  return rotations
end

loop do
  scanners.each do |scanner|
    if scanner[:x].nil?
      puts "#{scanner[:id]} unknown"
      rotations = get_rotations(scanner[:beacons])

      rotations.each do |rot|
        overlap = check_overlap(known_beacons, rot)

        if overlap.count >= 12
          puts "match found..."
          dx = rot[overlap[0]][:x] - rot[overlap[1]][:x]
          dy = rot[overlap[0]][:y] - rot[overlap[1]][:y]
          dz = rot[overlap[0]][:z] - rot[overlap[1]][:z]
          ref = known_beacons.combination(2).find { |a, b| a[0] - b[0] == dx && a[1] - b[1] == dy && a[2] - b[2] == dz }

          scanner[:x] = ref[0][0] - rot[overlap[0]].values[0]
          scanner[:y] = ref[0][1] - rot[overlap[0]].values[1]
          scanner[:z] = ref[0][2] - rot[overlap[0]].values[2]

          rot.each do |k, v|
            known_beacons << [scanner[:x] + v[:x], scanner[:y] + v[:y], scanner[:z] + v[:z]]
          end

          known_beacons.uniq!
          break
        end
      end

    end
  end

  found_count = 0
  scanners.each do |scanner|
    found_count += 1 unless scanner[:x].nil?
  end
  break if found_count == scanners.count
end

max_distance = 0

scanners.combination(2).to_a.each do |combo|
  dx = combo[0][:x] - combo[1][:x]
  dy = combo[0][:y] - combo[1][:y]
  dz = combo[0][:z] - combo[1][:z]

  distance = dx.abs + dy.abs + dz.abs
  max_distance = distance if distance > max_distance
end

puts max_distance
