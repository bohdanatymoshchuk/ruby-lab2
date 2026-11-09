numbers = Array.new(10) { rand(-20..20) }
puts "Масив: #{numbers.inspect}"

#бульбашка
indices = []
i = 0
while i < numbers.size
  indices << i
  i += 1
end

n = indices.size
i = 0
while i < n - 1
  j = 0
  while j < n - i - 1
   if numbers[indices[j]] > numbers[indices[j + 1]]
      indices[j], indices[j + 1] = indices[j + 1], indices[j]
    end
    j += 1
  end
  i += 1
end
puts "Спосіб 1 (while + if): #{indices.inspect}"

#ітератори
indices2 = numbers.each_index.sort_by { |idx| [numbers[idx], idx] }
puts "Спосіб 2 (each_index + sort_by): #{indices2.inspect}"

puts "Елементи в цьому порядку: #{indices2.map { |idx| numbers[idx] }.inspect}"
puts "Результати збігаються: #{indices == indices2}"