require 'test_helper'

class Api::V1::SpotTest < ActiveSupport::TestCase
  
  def setup
    @birdspotter = api_v1_birdspotters(:one)
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

  test "Latitude should not be valid as non numeric value" do
    @spot.latitude = "nsdfjkfjjfds"
    assert_not @spot.valid?
  end
  
  test "Longitude should not be valid as non numeric value" do
    @spot.longitude = "nsdfjkfjjfds"
    assert_not @spot.valid?
  end
end
