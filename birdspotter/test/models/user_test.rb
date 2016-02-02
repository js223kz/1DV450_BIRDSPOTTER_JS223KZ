require 'test_helper'


class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = User.new(username: "JS@powerapp.se", admin:"", password: "foobar", password_confirmation: "foobar")
  end

  test "User should be valid" do
    assert @user.valid?
  end
  
  test "User should not be valid without username" do
    @user.username = "  "
    assert_not @user.valid?
  end
  
  test "Password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  test "Password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "Username should not be too long" do
    @user.username = "a" * 70 + "@example.com"
    assert_not @user.valid?
  end
  
  test "Email validation should accept valid addresses as username" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.username = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test "Email validation should reject invalid addresses as username" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com user.hello@foo..com]
    invalid_addresses.each do |invalid_address|
      @user.username = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "Username should be unique" do
    duplicate_user = @user.dup
    duplicate_user.username = @user.username.downcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "Username should be lowercase" do
    assert @user.username.downcase
  end
  
  test "Removing a User should remove all users applications" do
    assert_difference('Application.count', difference = -1) do
      u = User.find(1)
      u.destroy
   end 
  end
end

