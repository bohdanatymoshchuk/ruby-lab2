require "csv"

SALES = File.join(__dir__, "sandbox", "sales.csv")
SUMMARY = File.join(__dir__, "sandbox", "summary.csv")

#фор іч і хеш накопичувач
totals = Hash.new(0.0)
CSV.foreach(SALES, headers: true) do |row|
    totals[row["Product"]] += row["Price"].to_f * row["Quantity"].to_i
end

CSV.open(SUMMARY, "w") do |csv|
    csv << %w[Product Total]
    totals.each { |product, total| csv << [product, total.round(2)] }
end
puts "Спосіб 1, результат у summary.csv:" 
puts File.read(SUMMARY)
puts

#фор іч ітератор і group_by
totals2 = CSV.foreach(SALES, headers: true)
             .group_by { |row| row["Product"] }
            .transform_values { |rows| rows.sum { |r| r["Price"].to_f * r["Quantity"].to_i }.round(2) }

puts "Спосіб 2:"
totals2.each { |product, total| puts "#{product}: #{total}" }

same = totals.transform_values { |v| v.round(2) } == totals2
puts "Результати збігаються: #{same}"