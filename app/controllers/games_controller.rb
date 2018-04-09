require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @word = params[:word]
    @letters = params[:letters].split(" ")
    @result = ""
    @word.split("").each do |letter|
      if @letters.include?(letter.upcase)
        @letters.slice!(@letters.index(letter.upcase))
      else
        @result = "Sorry but #{@word.upcase} can't be built out of #{@letters.join(",")}"
      end
    end
    if @result.empty?
      url = "https://wagon-dictionary.herokuapp.com/#{@word}"
      request = JSON.parse(open(url).read)
      if request["found"] == true
        @result = "Congratulations! #{@word.upcase} is a valid english word"
      else
        @result = "Sorry but #{@word.upcase} does not seem to be an English word..."
      end
    end
  end

end
