require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { username: "user@invalid",
                               password:              "hoppsan",
                               password_confirmation: "heppsan" }
    end
    assert_template 'users/new'
  end
  
  test "valid signup" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {username: "user@example.com",
                                            password:              "password",
                                            password_confirmation: "password" }
    end
    assert_template 'users/show'
    assert is_logged_in?
  end
  
end
