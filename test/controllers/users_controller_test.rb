require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  test "should redirect when users is not logged in" do
    get users_url
    assert_redirected_to(root_path)
  end

  test "should be able to sign up as a new user" do
    get new_user_path
    assert_response :success
  end

  test "should be not be able to edit a user when not logged in" do
    user = User.new(:first_name => "Test", :last_name => "Test", :email =>"test@mail.com", :username => "testusername", :password => "Password1232")
    user.save
    get edit_user_path(user)
    assert_redirected_to(root_path)
  end

end
