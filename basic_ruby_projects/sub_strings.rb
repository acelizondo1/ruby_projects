#Create a method that takes in a word and an array of substrings as parameters. It will look through the array and return a hash with the 
#substrings as the key and the amount of times they are found as the value.

#

def substrings (words, sub_array) 
    words_array = words.split(" ")
    return_hash = {}
    sub_array.each do |sub|
        words_array.each do |word|
            if word.downcase.match(sub)
                return_hash[sub] ? return_hash[sub] += 1 : return_hash[sub] = 1
            end
        end
    end
    return_hash
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("Howdy partner, sit down! How's it going?", dictionary)