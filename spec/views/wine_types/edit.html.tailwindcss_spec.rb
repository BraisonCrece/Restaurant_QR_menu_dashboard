require 'rails_helper'

RSpec.describe "wine_types/edit", type: :view do
  let(:wine_type) {
    WineType.create!()
  }

  before(:each) do
    assign(:wine_type, wine_type)
  end

  it "renders the edit wine_type form" do
    render

    assert_select "form[action=?][method=?]", wine_type_path(wine_type), "post" do
    end
  end
end
