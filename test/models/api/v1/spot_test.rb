require 'test_helper'

class Api::V1::SpotTest < ActiveSupport::TestCase
  
  def setup
    @spot = api_v1_spots(:one)
  end
  
  test "Spot should not be valid without latitude" do
    @spot.latitude = ""
    assert_not @spot.valid?
  end
  
  test "Spot should not be valid without longitude" do
    @spot.longitude = ""
    assert_not @spot.valid?
  end
end
