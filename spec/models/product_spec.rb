require "rails_helper"

RSpec.describe Product, type: :model do
  context "Has all its attributes" do
    it "can be created" do
      product = create(:product)
      expect(product).to be_valid
      p Product.all[-1]
    end
  end

  context "Does not have any its attributes" do
    attributes = ["title", "description", "active", "prize"]
    attributes.each do |attribute|
      it "doesn't have #{attribute}" do
        product = build(:product, "#{attribute}": nil)
        expect(product).not_to be_valid
        expect(product.errors.messages[attribute.to_sym]).to include("can't be blank")
      end
    end
  end

  context "class methods" do
    describe ".categorized_products" do
      let(:category1) { create(:category) }
      let(:category2) { create(:category) }

      let(:product1) { create(:product, title: "B Product", category: category1) }
      let(:product2) { create(:product, title: "A Product", category: category1) }
      let(:product3) { create(:product, title: "C Product", category: category2) }
      let(:inactive_product) { build(:product, title: "Inactive Product", category: category1, active: false) }

      it "does something" do
        p Product.all[-1]
      end

      # it "returns active products categorized and sorted by title" do
      #   categorized_products = Product.categorized_products

      #   expect(categorized_products.keys).to contain_exactly(category1.id, category2.id)
      #   expect(categorized_products[category1.id]).to eq([product2, product1]) # sorted by title
      #   expect(categorized_products[category2.id]).to eq([product3])
      # end

      # it "does not return inactive products" do
      #   categorized_products = Product.categorized_products

      #   expect(categorized_products.values.flatten).not_to include(inactive_product)
      # end
    end
  end
end
