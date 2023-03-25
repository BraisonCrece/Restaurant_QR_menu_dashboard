require "test_helper"

class ControlPanelControllerTest < ActionDispatch::IntegrationTest
  test "should get products" do
    get control_panel_products_url
    assert_response :success
  end

  test "should get allergens" do
    get control_panel_allergens_url
    assert_response :success
  end
end
