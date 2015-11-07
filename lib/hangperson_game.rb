class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word.downcase #hello
    @guesses=''
    @wrong_guesses=''
  end

  def guess(letter)  # guess('e') => false
    raise ArgumentError if letter.nil? || letter.empty? || (/[^a-zA-Z]/===letter)
    letter=letter.downcase
    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)
    
    if @word.include? letter
      @guesses += letter
    else
      @wrong_guesses += letter
    end 
  end
  
  def word_with_guesses
    # word = hello 
    # @guesses('eo') -> '-e--o'
    word.gsub(/[^"#{guesses}"]/, '-')
=begin
    word=@word
    word.split('').each do |l|
      word.gsub!(l,'-') if !@guesses.include? l #-e--
    end
    word
=end
  end
  
  def check_win_or_lose
    return :lose if wrong_guesses.length>=7
    # return :win if @word.split('').all?{|l| @guesses.include? l }
    return :win if word == word_with_guesses
    return :play
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
end
