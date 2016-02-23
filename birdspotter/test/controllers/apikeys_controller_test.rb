require 'test_helper'

class ApikeysControllerTest < ActionController::TestCase
  def setup
    @apikey = apikeys(:one)
  end
  
  test "should redirect create when not logged in" do
    assert_no_difference 'Apikey.count' do
      post :create, apikey: { 
        application_name: "Jättefinapp"
      }
    end
    assert_redirected_to root_url
  end
  
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Apikey.count' do
      delete :destroy, id: @apikey
    end
    assert_redirected_to login_url
  end
  
  test "should redirect destroy of someoneelses apikey" do
    log_in(users(:one))
    apikey = apikeys(:two)
    assert_no_difference 'Apikey.count' do
      delete :destroy, id: apikey
    end
    assert_redirected_to root_url
  end

end
