require 'rails_helper'

RSpec.describe "wine_types/new", type: :view do
  before(:each) do
    assign(:wine_type, WineType.new())
  end

  it "renders new wine_type form" do
    render

    assert_select "form[action=?][method=?]", wine_types_path, "post" do
    end
  end
end
