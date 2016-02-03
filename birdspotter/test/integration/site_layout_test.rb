require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'start/start'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", login_path
    
    get signup_path
    assert_select "title", full_title("Registrera konto")
  end
end
