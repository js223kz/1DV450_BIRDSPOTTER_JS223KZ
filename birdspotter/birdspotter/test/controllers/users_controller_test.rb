require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
    assert_select "title", "Registrera konto | Birdspotter"
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_path
  end

end
