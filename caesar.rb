def caesar_cipher(text, shift)
    # alphabet would be an array of letter a to letter z => "abcdefghijklmnopqrstuvwxyz" 
    alphabet = ('a'..'z').to_a.join
    # alphabet.size = 26 (26 letters)
    # % Operator = Modulus − Divides left hand operand by right hand operand and returns remainder.
    # Create breakpoint by shift factor
    breakpoint = shift % alphabet.size 
    # Shift the alphabet with the breakpoint
	shifted = alphabet[breakpoint..-1] + alphabet[0...breakpoint]
	cap_alphabet = alphabet.upcase
    cap_shifted = shifted.upcase
    # Returns a copy of str with the characters in from_str replaced by the corresponding characters in to_str. 
    # If to_str is shorter than from_str, it is padded with its last character in order to maintain the correspondence.
    # First tr, replace all small letters in the text with the shifted small letters
    semi = text.tr(alphabet,shifted)
    # Finalized encryption, replace all capital letters in the text with the shifted capitalized letters
    # Since below is the last line, it would be returned as the output of this function
    encrypted = semi.tr(cap_alphabet,cap_shifted)
end	

puts "What do you want to encrypt?"
text = gets.chomp
puts "What would be the shift (left) factor?"
shift = gets.chomp.to_i
puts caesar_cipher(text, shift)