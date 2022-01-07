require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

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

  test "Should return to edit with errors when user creation fails" do
    user = User.new(:first_name => "Test")
    post '/users',
         params: { user: { :first_name => "Test" } }
    puts response.body.to_s
    assert response.body.to_s.include?(
      '<li>Password can&#39;t be blank</li>
        <li>Last name can&#39;t be blank</li>
        <li>Username can&#39;t be blank</li>
        <li>Username has already been taken</li>
        <li>Username is too short (minimum is 2 characters)</li>
        <li>Email can&#39;t be blank</li>
        <li>Email has already been taken</li>
        <li>Email is invalid</li>')
  end

end
