require 'json'

class Hangman
  attr_accessor :word, :word_state, :lives

  def initialize
    @word = File.read("google-10000-english-no-swears.txt").split("\n").sample.downcase
    @word_state = Array.new(@word.length, "_")
    @lives = 6
  end

  def welcome
    puts "Welcome to Hangman!\n"
  end

  def make_guess
    puts "Please enter your guess. Enter 1 to save game: "
    gets.chomp.downcase
  end

  def display_word
    puts @word_state.join(" ")
    puts
  end

  def display_lives
    puts "You have #{@lives} lives left.\n"
  end

  def update_word_state(guess)
    @word.split("").each_with_index do |letter, index|
      if letter == guess
        @word_state[index] = guess
      end
    end
  end

  def new_or_load
    puts "New game (1) or Load game (2)?"
    gets.chomp.to_i
  end

  def load_game
    if File.exist?("save.json") && !File.zero?("save.json")
      save = JSON.parse(File.read("save.json"))
      @word = save["word"]
      @word_state = save["word_state"]
      @lives = save["lives"]
      puts "Game loaded!"
    else
      puts "No saved game found. Starting new game."
    end
  end

  def save_game
    save = {
      "word" => @word,
      "word_state" => @word_state,
      "lives" => @lives
    }

    File.open("save.json", "w") do |f|
      f.write(save.to_json)
    end

    puts "Game saved!"
    exit
  end

  def play
    welcome

    new_or_load == 2 ? load_game : nil

    while @lives > 0
      display_word
      display_lives

      guess = make_guess

      if @word.include?(guess)
        puts "Correct guess!"
        update_word_state(guess)
      elsif guess == "1"
        save_game
      else
        puts "Wrong guess!"
        @lives -= 1
      end

      if @word_state.join("") == @word
        puts "Congratulations! You won!"
        break
      end

      if @lives == 0
        puts "Sorry, you lost! The word was #{@word}."
      end
    end
  end
end