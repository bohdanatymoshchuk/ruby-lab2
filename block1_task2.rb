numbers = Array.new(10) { rand(-10..10) }
puts "Масив: #{numbers.inspect}"

#вайл+іф
sum1 = 0
i = 0
while i < numbers.size
  sum1 += numbers[i] if numbers[i] < 0
  i += 1
end
puts "Спосіб 1: #{sum1}"

#ітератори
sum2 = numbers.select(&:negative?).sum
puts "Спосіб 2: #{sum2}"

puts "Результати збігаються: #{sum1 == sum2}"