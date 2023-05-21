require "rails_helper"

RSpec.describe User, type: :model do
  context "Validations" do
    it { should validate_presence_of(:email) }
  end
end
