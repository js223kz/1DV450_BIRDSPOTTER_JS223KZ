require 'test_helper'

class Api::V1::BirdspotterTest < ActiveSupport::TestCase
  def setup
    @birdspotter = Api::V1::Birdspotter.new(user_name: "Krokodilen", 
    email: "krokodilen@farlig.se", 
    password: "foobar", password_confirmation: "foobar")
  end

  test "Birdspotter should be valid" do
    assert @birdspotter.valid?
  end
  
  test "Birspotter should not be valid without username" do
    @birdspotter.user_name = "  "
    assert_not @birdspotter.valid?
  end
  
  test "Username should have a minimum length of four characters" do
    @birdspotter.user_name = @birdspotter.user_name = "a" * 3
    assert_not @birdspotter.valid?
  end
  
  test "Username should not be too long" do
    @birdspotter.user_name = "a" * 31
    assert_not @birdspotter.valid?
  end
  
  test "Username should be unique" do
    duplicate_birdspotter = @birdspotter.dup
    duplicate_birdspotter.user_name = @birdspotter.user_name
    @birdspotter.save
    assert_not duplicate_birdspotter.valid?
  end
  
  test "Birdspotter should not be valid without password" do
    @birdspotter.password = @birdspotter.password_confirmation = " " * 6
    assert_not @birdspotter.valid?
  end
  
  test "Password should have a minimum length of 6 characters" do
    @birdspotter.password = @birdspotter.password_confirmation = "a" * 5
    assert_not @birdspotter.valid?
  end

  test "Birdspotter should not be valid without email" do
    @birdspotter.email = ""
    assert_not @birdspotter.valid?
  end
  
  test "Email should not be more than 70 characters long" do
    @birdspotter.email = "a" * 70 + "@example.com"
    assert_not @birdspotter.valid?
  end
  
  test "Email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @birdspotter.email = valid_address
      assert @birdspotter.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "Email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com user.hello@foo..com]
    invalid_addresses.each do |invalid_address|
      @birdspotter.email = invalid_address
      assert_not @birdspotter.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "Email should be unique" do
    duplicate_birdspotter = @birdspotter.dup
    duplicate_birdspotter.email = @birdspotter.email
    @birdspotter.save
    assert_not duplicate_birdspotter.valid?
  end
end
