require 'test_helper'

class ApplicationTest < ActiveSupport::TestCase
  
  def setup
    @application = Application.new(application_name: "JS@powerapp.se", application_key: "foobarlnlzvnvklsnvdkslvdskldvnksnvlsnklsnk")
  end
  
  test "Application should be valid" do
    assert @application.valid?
  end
  
  test "Application should not be valid without name" do
    @application.application_name = ""
    assert_not @application.valid?
  end
  
  test "Application should not be valid without key" do
    @application.application_key = ""
    assert_not @application.valid?
  end
  
  test "Name should not be shorter than 4 characters" do
    @application.application_name = "aaa"
    assert_not @application.valid?
  end
  
  test "Name should not be longer than 70 characters" do
    @application.application_name = "aaa"*68
    assert_not @application.valid?
  end
  
  test "Key should not be shorter than 20 characters" do
    @application.application_key = "aaa" *6
    assert_not @application.valid?
  end
  
  test "Key should not be longer than 255 characters" do
    @application.application_key = "a" * 256
    assert_not @application.valid?
  end
  
end
