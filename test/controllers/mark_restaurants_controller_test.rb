require 'test_helper'

class MarkRestaurantsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get mark_restaurants_create_url
    assert_response :success
  end

  test "should get destroy" do
    get mark_restaurants_destroy_url
    assert_response :success
  end

end
