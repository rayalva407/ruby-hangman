class Hangman

  def initialize
    @word = File.read("google-10000-english-no-swears.txt").split("\n").sample().downcase
    @word_state = Array.new(@word.length, "_")
    @lives = 6
  end

  def welcome
    puts "Welcome to Hangman!"
  end

  def make_guess
    puts "Please enter your guess:"
    gets.chomp
  end

  def display_word
    puts @word_state.join(" ")
  end

  def display_lives
    puts "You have #{@lives} lives left."
  end

  def update_word_state(guess)
    @word.split("").each_with_index do |letter, index|
      if letter == guess
        @word_state[index] = guess
      end
    end
  end

  def play
    welcome
    while @lives > 0
      display_word
      display_lives

      guess = make_guess

      if @word.include?(guess)
        update_word_state(guess)
      else
        puts "Sorry, wrong guess! Try again."
        @lives -= 1
      end

      if @word_state.join("") == @word
        puts "Congratulations! You won!"
        break
      end
    end
  end
end