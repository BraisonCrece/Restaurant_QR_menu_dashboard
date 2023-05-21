require "rails_helper"

RSpec.describe Product, type: :model do
  before :example do
    Product.delete_all
  end

  context "Validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:prize) }
  end

  context "Associations" do
    it { should belong_to(:category) }
    it { should have_and_belong_to_many(:allergens) }
    it { should have_one_attached(:picture) }
  end

  context "Methods" do
    describe "#process_image" do
      context "with a valid format" do
        it "processes and attaches an image" do
          file = fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "test.jpg"), "image/jpeg")
          subject.process_image(file)
          expect(subject.picture).to be_attached
        end
      end

      context "whit an invalid format" do
        it "raise an error" do
          file = fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "wrong_format.avi"), "video/avi")
          expect { subject.process_image(file) }.to raise_error(Vips::Error)
        end
      end
    end

    context ".categorized_products" do
      let!(:inactive_product) { create(:product, active: false) }
      let!(:product1) { create(:product, active: true, title: "ZProduct", category_id: 1) }
      let!(:product2) { create(:product, active: true, title: "AProduct", category_id: 1) }
      let!(:product3) { create(:product, active: true, title: "BProduct", category_id: 2) }

      it "returns only active products" do
        expect(Product.categorized_products.keys).not_to include(inactive_product.category_id)
      end

      it "orders products by title" do
        expect(Product.categorized_products[product1.category_id].first).to eq(product2)
        expect(Product.categorized_products[product1.category_id].second).to eq(product1)
      end

      it "groups products by category_id" do
        expect(Product.categorized_products[product1.category_id].count).to eq(2)
        expect(Product.categorized_products[product3.category_id].count).to eq(1)
      end
    end
  end
end
