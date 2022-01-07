require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get search_index_url
    assert_response :success
  end

  test "should find word and return the found route found" do
    get found_word_path(:search_term => "lexicon")
    assert_response :success
    assert response.body.to_s.include?("lexicon")
    assert response.body.to_s.include?("<b>Definition : </b> the vocabulary of a person, language, or branch of knowledge.")
  end

  test "should not find word and redirect to notFound" do
    get found_word_path(:search_term => "222lexicon111")
    assert response.body.to_s.include?('You are being <a href="http://www.example.com/search/notFound">redirected</a>')
  end

  test "should remove spaces from text" do
    get found_word_path(:search_term => "222 lexicon 111")
    assert response.body.to_s.include?('You are being <a href="http://www.example.com/search/notFound">redirected</a>')

    get found_word_path(:search_term => "le x i con ")
    assert_response :success
    assert response.body.to_s.include?("lexicon")
    assert response.body.to_s.include?("<b>Definition : </b> the vocabulary of a person, language, or branch of knowledge.")
  end

end
