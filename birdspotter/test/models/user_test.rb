require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = User.new(username: "JS@powerapp.se", password: "ladymac74")
  end

  test "User should be valid" do
    assert @user.valid?
  end
  
  test "should not be valid without username and password" do
    @user.username = ""
    @user.password = ""
    
    assert_not @user.valid?
  end
  
  test "Should not be valid without username" do
    @user.username = ""
    
    assert_not @user.valid?
  end
  
  test "Should not be valid without password" do
    @user.password = ""
    assert_not @user.valid?
  end
  
  test "Password should not be shorter than 6 cahracters" do
    @user.password = "aaaa"
    assert_not @user.valid?
  end
  
  test "Username or password should not be too long" do
    @user.username = "a" * 244 + "@example.com"
    @user.password = "a" * 244 + "lalala"
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
end
