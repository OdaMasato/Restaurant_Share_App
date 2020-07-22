require 'test_helper'

class RestaurantInfosControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get restaurant_infos_index_url
    assert_response :success
  end

end
