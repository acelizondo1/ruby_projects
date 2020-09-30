#Take in a string and a number representing shift, positive number representing right shift and negative representing left shift.
#If number goes past A or Z it will wrap 

#convert string to letters in an array
#determine which characters to shift
#Shift each letter by shift key
#Check if letter nees to be wrapped

def caeser_cipher (str, shift)
    lowercase = ('a'..'z').to_a
    uppercase = ('A'..'Z').to_a
    shift = shift%lowercase.length
    
    str_array = str.split("")
    str_array.map! do |str_entry| 
        if lowercase.index(str_entry) != nil
            new_entry = lowercase.index(str_entry) + shift
            if new_entry >= lowercase.length
                new_entry -= lowercase.length
            end
            lowercase[new_entry]
        elsif uppercase.index(str_entry) != nil
            new_entry = uppercase.index(str_entry) + shift
            if new_entry >= lowercase.length
                new_entry -= lowercase.length
            end
            uppercase[new_entry]
        else
            str_entry
        end
    end
    str_array.join
end


puts "What text would you like to encode?"
message = gets.chomp
puts "Enter a shift number:"
key = gets.chomp.to_i
encoded_message = caeser_cipher(message, key)
puts "Your encoded message is #{encoded_message}"