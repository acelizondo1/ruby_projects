

class Hangman
    @@INCORRECT_GUESSES_ALLOWED = 6

    def initialize()
        @word = choose_word
        @guessed_word = Array.new(@word.length)
        @incorrect_letters = []
        @incorrect_guesses = 0
        puts @word.to_s
    end

    def start_game
        until @incorrect_guesses == @@INCORRECT_GUESSES_ALLOWED || @guessed_word == @word
            puts "You have #{@@INCORRECT_GUESSES_ALLOWED - @incorrect_guesses} wrong guesses left!\n"
            display_word
            guessed_letter = ask_for_guess
            check_guess(guessed_letter)
        end
        if @guessed_word == @word
            puts "Congrats! You won the game!"
        else
            puts "You ran out of guesses. Try Again!"
        end
    end


    private
    def check_guess(guess_letter)
        if @word.include?(guess_letter)
            @word.each_with_index do |letter , i|  
                @guessed_word[i] = letter if guess_letter == letter
            end
        else
            @incorrect_letters.push(guess_letter)
            @incorrect_guesses += 1
        end
    end

    def display_word
        puts ""
        @guessed_word.each do |letter|
            if letter
                print letter
            else
                print " "
            end
            print " "
        end
        print "\n"
        @guessed_word.each { |letter| print "_ " }
        puts "\n\nIncorrectly guessed letters: \n"
        @incorrect_letters.each { |letter| print letter + ", " }
        puts "\n\n"
    end

    def ask_for_guess
        response_letter = ""
        until response_letter.length == 1 && letter?(response_letter) && !guessed?(response_letter)
            puts "Please enter your next guess(must be a letter(must be a letter not yet guessed):"
            response_letter = gets.chomp()
        end
        response_letter.downcase
    end

    def choose_word
        words = File.readlines "5desk.txt" 
        word = ""
        until word.length >= 5 && word.length <= 12
            word = words[rand(words.length)].chomp
        end
        word.downcase.split('')
    end

    def guessed?(letter)
        @incorrect_letters.include?(letter.downcase) || @guessed_word.include?(letter.downcase) ? true : false
    end

    def letter?(letter)
        letter =~ /[[:alpha:]]/
    end
end

Hangman.new.start_game