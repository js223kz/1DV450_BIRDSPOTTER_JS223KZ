require 'test_helper'

class StartControllerTest < ActionController::TestCase
  
  test "should get start" do
    get :start
    assert_response :success
    assert_select "title", "Birdspotter"
  end
end
