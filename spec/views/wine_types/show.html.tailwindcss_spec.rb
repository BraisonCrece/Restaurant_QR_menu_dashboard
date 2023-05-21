require 'rails_helper'

RSpec.describe "wine_types/show", type: :view do
  before(:each) do
    assign(:wine_type, WineType.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
