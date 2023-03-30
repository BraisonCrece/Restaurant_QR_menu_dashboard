require "test_helper"

class TranslateControllerTest < ActionDispatch::IntegrationTest
  test "should get translate" do
    get translate_translate_url
    assert_response :success
  end
end
