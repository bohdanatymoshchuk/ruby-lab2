require "csv"

products = {
    "Apple" => 8.5,
    "Banana" => 50.0,
    "Milk" => 42.0,
    "Bread" => 30.0,
    "Cheese" => 150.0
}

CSV.open(File.join(__dir__, "sandbox", "sales.csv"), "w") do |csv|
    csv << %w[Product Price Quantity]
    20.times do
        name, price = products.to_a.sample
        csv << [name, price, rand(1..10)]
    end
end
puts "sandbox/sales.csv створено"