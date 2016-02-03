require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { username: "user@invalid",
                               password:              "hoppsan",
                               password_confirmation: "heppsan" }
    end
    assert_template 'users/new'
  end
end
