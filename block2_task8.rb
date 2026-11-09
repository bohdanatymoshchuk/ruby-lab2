rows = 3
cols = 4
matrix = Array.new(rows) { Array.new(cols) { rand(-10..20) } }
puts "Матриця:"
matrix.each { |row| puts row.map { |x| x.to_s.rjust(4) }.join } 

#вкладені while
min1 = matrix[0][0]
i = 0
while i < rows
    j = 0
    while j < cols
        min1 = matrix[i][j] if matrix[i][j] < min1
        j +=1
    end
    i += 1
end
puts "Спосіб 1: мінімум = #{min1}"

#ітератори
min2 = matrix.flatten.min
puts "Спосіб 2: мінімум = #{min2}"

puts "Результати збігаються: #{min1 == min2}"