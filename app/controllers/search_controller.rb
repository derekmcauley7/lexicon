require 'net/http'
require 'json'
require 'uri'

class SearchController < ApplicationController
  def index
  end

  def found
    @word = Word.where(:word => params[:word]).first
    if @word.nil?
      puts params[:word]
      json_response = request_word_from_api(params[:word])
      puts json_response
      if json_response.any?{|hash| hash['title'] == "No Definitions Found"}
        redirect_to("search/notFound")
      else
        @word = Word.new
        puts "Word test " +  json_response[1]["word"]
        @word.word = json_response[1]["word"]
        @word.save
      end
    end
  end

  def notFound
  end

  private

  def request_word_from_api(word)
    uri = URI("https://api.dictionaryapi.dev/api/v2/entries/en/" + word.to_s)
    puts uri
    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(uri, 'Content-Type' => 'application/json')
      request.body = {parameter: 'value'}.to_json
      response = http.request request # Net::HTTPResponse object
      JSON.parse(response.body)
    end
  end
end
