require 'net/http'
require 'json'
require 'uri'

class SearchController < ApplicationController
  def index
  end

  def found
    puts " Search term " + params[:search_term]
    @word = Word.where(:word => params[:search_term]).first
    if @word.nil?
      response = request_word_from_api(params[:search_term])
      if response[0]["title"] == "No Definitions Found" || response[0]["word"].nil?
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
      @word.count+=1
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
