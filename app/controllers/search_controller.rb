require 'net/http'
require 'json'
require 'uri'

class SearchController < ApplicationController
  def index
  end

  def found
    @word = Word.where(:word => params[:search_term]).first
    if @word.nil?
      response = request_word_from_api(params[:search_term].delete(' '))
      if response.to_s.include? "No Definitions Found"
        redirect_to("/search/notFound")
      else
        @word = Word.new
        @word.word = response[0]["word"]
        @word.count = 1
        @word.audio = response[0]["phonetics"][0]["audio"]
        @word.origin = response[0]["origin"]
        @word.partOfSpeech = response[0]["meanings"][0]["partOfSpeech"]
        @word.definition = response[0]["meanings"][0]["definitions"][0]["definition"]
        @word.example = response[0]["meanings"][0]["definitions"][0]["example"]
        @word.save
      end
    else
      if @word.count.nil?
        @word.count = 1
      else
        @word.count+=1
      end
      @word.save
    end

  end

  def notFound
  end

  private

  def request_word_from_api(word)
    uri = URI("https://api.dictionaryapi.dev/api/v2/entries/en/" + word.to_s)
    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(uri, 'Content-Type' => 'application/json')
      request.body = {parameter: 'value'}.to_json
      response = http.request request # Net::HTTPResponse object
      JSON.parse(response.body)
    end
  end
end
