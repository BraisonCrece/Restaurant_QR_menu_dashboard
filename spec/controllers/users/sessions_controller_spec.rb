require "rails_helper"

RSpec.describe Users::SessionsController, type: :controller do
  it "shows the user log in page" do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    get :new
    expect(response).to have_http_status(:ok)
  end

  it "allows the user's sign_in action" do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    # post :create, params: { user: { email: user.email, password: user.password } }
    user = create(:user)
    sign_in user
    expect(response).to have_http_status(:ok)
    expect(subject.current_user).to_not be_nil
  end
end
