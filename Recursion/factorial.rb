def factorial(n)
    if n == 0
      1
    else
      n * factorial(n-1)
    end
  end

puts "Give me a number to calculate the factorial of: "
number = gets.chomp.to_i
puts "The factorial of #{number} is #{factorial(number)}. "