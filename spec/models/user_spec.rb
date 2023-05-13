require "rails_helper"

RSpec.describe User, type: :model do
  context "with valid data" do
    it "can be created" do
      user = create(:user)
      expect(user).to be_valid
    end
  end

  context "with invalid data" do
    it "must have an email" do
      user = User.new(password: "Abc123.")
      expect(user.valid?).to eq(false)
      expect { user.save }.not_to change { User.count }
      expect(user.errors.messages[:email][0]).to eq("can't be blank")
      expect(user.errors.messages[:email][1]).to eq("É obrigatorio o uso dun email")
    end

    it "must have an password" do
      user = User.new(email: "Manolo")
      expect(user.valid?).to eq(false)
      expect { user.save }.not_to change { User.count }
    end

    it "hasn't an unique email" do
      user = create(:user)
      user_2 = build(:user, email: user.email, password: "Abc123..")
      expect(user_2.valid?).to eq(false)
    end
  end
end
