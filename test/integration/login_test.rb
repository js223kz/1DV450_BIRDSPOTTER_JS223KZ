require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
  end

 test "login with invalid information" do
    get root_path
    assert_template 'start/start'
    post login_path, login: { username: "", password: "" }
    assert_template 'start/start'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "login with valid information followed by logout" do
    get root_path
    post login_path, login: { username: @user.username, password: 'hejsanhoppsan' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    get '/logout'
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end
