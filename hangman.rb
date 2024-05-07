class Hangman

  def initialize
    @word = File.read("google-10000-english-no-swears.txt").split("\n").sample().downcase
  end

  def welcome
    puts "Welcome to Hangman!"
  end

  def make_guess
    puts "Please enter your guess:"
    gets.chomp
  end

  def display_word
    @word.each_char do |char|
      print "_ "
    end
    puts
  end
  
  def play
    welcome
    @word
  end


end