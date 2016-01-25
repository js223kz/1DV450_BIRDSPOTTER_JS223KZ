require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "Save user with username and password" do
  user = User.new
  user.username = "joszep"
  user.password = "ladymac74"
  
  assert user.save
  end
  
  test "Don't save without username and password" do
    user = User.new
    
    assert_not user.save
  end
  
end
