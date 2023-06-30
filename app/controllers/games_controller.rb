require 'open-uri'
require 'json'
class GamesController < ApplicationController
  def new
    vowels = ["A", "E", "I", "O", "U"]
    @letters = Array.new(7) { ('A'..'Z').to_a.sample }
    3.times {@letters << vowels.sample}
  end

  def score
    @answer = params[:answer].upcase.split("")
    @letters = params[:letters]
    @english_word = english_word?(@answer)
    @included = included?(@answer, @letters)
    @grid = @letters
      if @answer.all? { |letter| @answer.count(letter) <= @grid.count(letter) }
        if english_word?(@answer)
          @string = "CONGRATS! #{@answer.join} is a valid English Word"
        else
          @string = "sorry but #{@answer.join} does not seem to be a valid English word..."
        end
      else
        @string = "sorry but #{@answer.join} can't be built out of: #{@grid}"
      end
  end


  def included?(answer, letters)
    answer.all? { |letter| answer.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word.join}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
