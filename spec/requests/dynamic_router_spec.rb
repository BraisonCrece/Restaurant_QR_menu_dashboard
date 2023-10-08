require 'rails_helper'

RSpec.describe "DynamicRouters", type: :request do
  describe "GET /call" do
    it "returns http success" do
      get "/dynamic_router/call"
      expect(response).to have_http_status(:success)
    end
  end

end
