require 'test_helper'

class MarkRestaurantControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get mark_restaurant_create_url
    assert_response :success
  end

end
