rows = 3
cols = 4
matrix = Array.new(rows) { Array.new(cols) { rand(-10..20) } }
puts "Матриця:"
matrix.each { |row| puts row.map { |x| x.to_s.rjust(4) }.join }

#while
product1 = 1
col = 0
while col < cols
  max = matrix[0][col]
  row = 1
  while row < rows
    max = matrix[row][col] if matrix[row][col] > max
    row += 1
  end
  puts "Максимум стовпця #{col}: #{max}"
  product1 *= max
  col += 1
end
puts "Спосіб 1: добуток максимумів = #{product1}"

#ітератори
maxes = matrix.transpose.map(&:max)
product2 = maxes.reduce(:*)
puts "Спосіб 2: максимуми #{maxes.inspect}, добуток = #{product2}"

puts "Результати збігаються: #{product1 == product2}"