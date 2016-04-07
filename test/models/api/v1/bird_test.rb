require 'test_helper'

class Api::V1::BirdTest < ActiveSupport::TestCase
  def setup
    @bird = api_v1_birds(:one)
  end
  
  test "Bird should not be valid without bird name" do
    @bird.bird_name = ""
    assert_not @bird.valid?
  end
  
  test "Bird should not be valid without latin name" do
    @bird.latin_name = ""
    assert_not @bird.valid?
  end
  
  test "Bird should not be valid without regularity" do
    @bird.regularity = ""
    assert_not @bird.valid?
  end
  
  test "Bird name and latin name should be unique" do
    duplicate_bird = @bird.dup
    duplicate_bird.bird_name = @bird.bird_name.downcase
    duplicate_bird.latin_name = @bird.latin_name.downcase
    @bird.save
    assert_not duplicate_bird.valid?
  end
 
end
