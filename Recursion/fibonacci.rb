def fib(n)
    if n == 0
      0
    elsif n == 1
      1
    else
      fib(n-1) + fib(n-2)
    end
  end


puts "Give me a number to calculate the fibonacci value of that position: "
number = gets.chomp.to_i
puts "The fibonacci value at position #{number} is #{fib(number)}. "

  