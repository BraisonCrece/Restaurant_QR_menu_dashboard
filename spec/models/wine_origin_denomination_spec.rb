require "rails_helper"

RSpec.describe WineOriginDenomination, type: :model do
  context "Relations" do
    it { have_many(:wines) }
  end
end
