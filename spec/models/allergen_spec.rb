require "rails_helper"

RSpec.describe Allergen, type: :model do
  context "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:icon) }
  end

  context "Associations" do
    it { should have_and_belong_to_many(:products) }
    it { should have_one_attached(:icon) }
  end
end
