require 'rails_helper'

RSpec.describe "Products", type: :system do
  describe "visiting the products index" do
    let!(:category) { create(:category) }
    let!(:product1) { create(:product, title: "Product 1", category: category) }
    let!(:product2) { create(:product, title: "Product 2", category: category) }

    it "displays products" do
      visit products_path
      expect(page).to have_text("Product 1")
      expect(page).to have_text("Product 2")
    end
  end

  describe "creating a new product" do
    let!(:category) { create(:category) }
    let!(:user) { create(:user) }

    before do
      login_as(user)
    end

    context "when user is logged in" do
      it "successfully creates a new product" do
        visit new_product_path
        fill_in "Nome", with: "Product 1"
        select category.name, from: "product_category_id", match: :first, visible: false
        click_button "Gardar"
        expect(page).to have_text("Engadir producto")
      end
    end

    context "when user is not logged in" do
      before do
        logout
      end

      it "redirects to the login page" do
        visit new_product_path
        expect(current_path).to eq new_user_session_path
        expect(page).to have_text("You need to sign in or sign up before continuing.")
      end
    end
  end
end
