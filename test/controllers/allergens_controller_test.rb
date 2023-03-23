require "test_helper"

class AllergensControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get allergens_index_url
    assert_response :success
  end

  test "should get new" do
    get allergens_new_url
    assert_response :success
  end
end
