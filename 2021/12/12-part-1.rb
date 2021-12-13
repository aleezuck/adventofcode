file = File.read("input.txt")
input = file.split("\n").map { |x| x.split("-") }

connections = Hash.new { |h, k| h[k] = [] }

input.each do |arr|
  if arr.include?("start")
    if arr[0] == "start"
      connections["start"] << arr[1]
    elsif arr[1] == "start"
      connections["start"] << arr[0]
    end
  else
    connections[arr[0]] << arr[1]
  end
end

all_connections = connections.dup

connections.each do |key, value|
  value.each do |v|
    all_connections[v] << key
  end
end

all_connections.map do |k, v|
  all_connections[k] = v.uniq.select { |x| x != "start" }
end

all_paths = []

all_connections["start"].each do |val|
  path = ["start", val]
  all_paths << path
end

loop do
  length = all_paths.length

  all_paths.map! do |path|
    unless path[-1] == "end"
      new_paths = []

      all_connections[path[-1]].each do |val|
        if val.upcase == val
          new_path = path.dup
          new_path << val
          new_paths << new_path
        elsif !path.include?(val)
          new_path = path.dup
          new_path << val
          new_paths << new_path
        else
          new_paths << path
        end
      end

      new_paths
    else
      [path]
    end
  end
  # pp all_paths

  all_paths.flatten!(1).uniq!

  break if all_paths.length == length
end

puts all_paths.uniq.select { |x| x[-1] == "end" }.count
