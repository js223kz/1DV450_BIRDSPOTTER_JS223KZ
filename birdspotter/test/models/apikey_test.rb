require 'test_helper'

class ApikeyTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:one)
    @apikey = @user.apikeys.build(application_name: "demo")
  end
  
  test "Apikey should be valid" do
    assert @apikey.valid?
  end
  
  test "User id should be present" do
    @apikey.user_id = nil
    assert_not @apikey.valid?
  end
  
  test "Apikey should not be valid without name" do
    @apikey.application_name = ""
    assert_not @apikey.valid?
  end

  test "Name should not be shorter than 4 characters" do
    @apikey.application_name = "aaa"
    assert_not @apikey.valid?
  end
  
  test "Name should not be longer than 70 characters" do
    @apikey.application_name = "aaa"*68
    assert_not @apikey.valid?
  end
  
  test "Latest apikey should first in order" do
    assert_equal apikeys(:latest), Apikey.first
  end
end
