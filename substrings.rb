#Ask user for string
print "Please type in a phrase:"
#Create a variable to store the string
string = gets.chomp.to_s

#Dictionary array of words to count
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]


def substrings(string, dictionary)
  #Initialize hash
  hash = Hash.new(0)
  #split string into an array
  string_arr = string.downcase.split(" ") 
  
  #Loop through each word of the string array
  string_arr.each do |string|
    #Loop through each word of the dictionary array to determine if substrings are included
    dictionary.each do |word|
      if string.include? word
        #Add word and count to hash
        hash[word] += 1
      end
    end
  end
  print hash
end


#Call function
substrings(string, dictionary)