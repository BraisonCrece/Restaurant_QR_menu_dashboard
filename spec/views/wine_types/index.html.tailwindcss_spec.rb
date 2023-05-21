require 'rails_helper'

RSpec.describe "wine_types/index", type: :view do
  before(:each) do
    assign(:wine_types, [
      WineType.create!(),
      WineType.create!()
    ])
  end

  it "renders a list of wine_types" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
