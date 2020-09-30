def palindrome(string)
  if string.length == 1 || string.length == 0
    true
  else
    if string[0] == string[-1]
      palindrome(string[1..-2])
    else
      false
    end
  end
end

puts "Check a palindrome: "
text = gets.chomp

if (palindrome(text))
    puts "#{text} is a palindrome"
else
    puts "#{text} is not a palindrome"
end