require 'yaml'

class Hangman
    @@INCORRECT_GUESSES_ALLOWED = 7
    @@HANGMAN = [
        ["  _____ ", " |     |", "       |", "       |", "       |", "       |", "_______|"],
        ["  _____ ", " |     |", " O     |", "       |", "       |", "       |", "_______|"],
        ["  _____ ", " |     |", " O     |", " |     |", "       |", "       |", "_______|"],
        ["  _____ ", " |     |", " O     |", "_|     |", "       |", "       |", "_______|"],
        ["  _____ ", " |     |", " O     |", "_|_    |", "       |", "       |", "_______|"],
        ["  _____ ", " |     |", " O     |", "_|_    |", " |     |", "       |", "_______|"],
        ["  _____ ", " |     |", " O     |", "_|_    |", " |     |", "/      |", "_______|"],
        ["  _____ ", " |     |", " O     |", "_|_    |", " |     |", "/ \\    |", "_______|"]
    ]
    
    def initialize()
        @word = choose_word
        @guessed_word = Array.new(@word.length)
        @incorrect_letters = []
        @incorrect_guesses = 0
        puts @word.to_s
    end

    def start_game
        puts "Would you like to load the last game?"
        load_response = ""
        until load_response == "yes" || load_response == "no"
            load_response = gets.chomp.downcase
        end
        load_game if load_response == "yes"
        until @incorrect_guesses == @@INCORRECT_GUESSES_ALLOWED || @guessed_word == @word
            p @word
            puts "You have #{@@INCORRECT_GUESSES_ALLOWED - @incorrect_guesses} wrong guesses left!\n"
            display_hangman
            display_word
            guessed_letter = ask_for_guess
            guessed_letter == "save" ? save_game : check_guess(guessed_letter)
        end
        if @guessed_word == @word
            puts "Congrats! You won the game!"
        else
            display_hangman
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

    def ask_for_guess
        response_letter = ""
        until (response_letter.length == 1 && letter?(response_letter) && !guessed?(response_letter)) || response_letter.downcase == "save"
            puts "Please enter your next guess(must be a letter(must be a letter not yet guessed) or enter 'save' to save yor game for later:"
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

    def display_word
        puts ""
        @guessed_word.each do |letter|
            if letter
                print letter
            else
                print "_"
            end
            print " "
        end
        puts "\n\nIncorrectly guessed letters: \n"
        @incorrect_letters.each { |letter| print letter + ", " }
        puts "\n\n"
    end

    def save_game
        File.open("save_game.yml", "w") do |file|
            data = YAML.dump ({
                :word => @word,
                :guessed_word => @guessed_word,
                :incorrect_letters => @incorrect_letters,
                :incorrect_guesses => @incorrect_guesses
            })
            file.puts data
        end
        puts "You've successfully saved your game. Goodbye"
        exit(0)
    end

    def load_game
        load_data = YAML.load(File.read("save_game.yml"))
        @word = load_data[:word]
        @guessed_word = load_data[:guessed_word]
        @incorrect_letters = load_data[:incorrect_letters]
        @incorrect_guesses = load_data[:incorrect_guesses]
    end

    def display_hangman
        p @incorrect_guesses
        @@HANGMAN[@incorrect_guesses].each { |row| puts row }
    end

    def guessed?(letter)
        @incorrect_letters.include?(letter.downcase) || @guessed_word.include?(letter.downcase) ? true : false
    end

    def letter?(letter)
        letter =~ /[[:alpha:]]/
    end
end

Hangman.new.start_game