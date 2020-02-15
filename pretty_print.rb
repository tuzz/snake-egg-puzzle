require "json"

puts "Waiting for solution..."

input = ARGF.read
data = JSON.parse(input, symbolize_names: true)
grid = data.fetch(:grid)

grid.each do |row|
  row.each do |digit|
    digit = "█" if digit <= 0

    print digit
    print " "
  end
  puts
end
