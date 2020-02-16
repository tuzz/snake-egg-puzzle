require "json"

puts "Waiting for input..."

input = ARGF.read
data = JSON.parse(input, symbolize_names: true)
grid = data.fetch(:grid)

puts "Writing minimal.snt..."
program = File.read("snake-egg.snt").lines
program.insert(8, "invariant grid != #{grid.inspect};")
File.open("minimal.snt", "w") { |f| f.write program.join }

puts "Compiling program..."
system("sentient --compile --optimise minimal.snt > minimal.json")

coords = { regions: [] }
regions = coords[:regions]

grid.each.with_index do |row, y|
  row.each.with_index do |n, x|
    coords[n] ||= []
    coords[n].push([x, y, n])

    regions.push([x, y, n]) if n > 0
  end
end

head_and_tail = coords[-1]
minimals = []

counter = 1
puts "Searching..."

1.upto(regions.size) do |number_of_digits|
  all_skipped = true

  regions.combination(number_of_digits).each do |selected_numbers|
    selection = head_and_tail + selected_numbers
    covered = minimals.any? { |m| selection.all? { |s| m.include?(s) } }

    if covered
      all_skipped = false
      next
    end

    assignments = { grid: {} }
    selection.each do |x, y, n|
      assignments[:grid][y] ||= {}
      assignments[:grid][y][x] = n
    end
    json = assignments.to_json

    puts "Iteration #{counter}, testing #{json}"
    output = `sentient --run minimal.json --machine lingeling --assign '#{json}'`
    counter += 1

    if JSON.parse(output).empty?
      minimals.push(selection)
      puts "\nThis combination of starting numbers uniquely define a solution:"

      selected_numbers.each do |x, y, n|
        puts "  - a #{n} at coordinate (#{x}, #{y})"
      end
    end
  end

  break if all_skipped
end

5.times { puts }
puts "Finished. Here's the grid again:"
puts grid.inspect
puts
puts "Here's the minimal set of starting numbers that uniquely define solutions:"
minimals.each { |m| puts m.inspect }
