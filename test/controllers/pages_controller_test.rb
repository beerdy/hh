require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get dorado" do
    get pages_dorado_url
    assert_response :success
  end

  test "should get bavariya" do
    get pages_bavariya_url
    assert_response :success
  end

  test "should get contacts" do
    get pages_contacts_url
    assert_response :success
  end

end
