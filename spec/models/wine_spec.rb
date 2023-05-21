require "rails_helper"

RSpec.describe Wine, type: :model do
  context "Relations" do
    it { should belong_to(:wine_origin_denomination) }
    it { should have_one_attached(:image) }
  end
  context "Validations" do
    it { should validate_numericality_of(:price_per_glass).is_greater_than(0) }
  end

  context "Methods" do
    describe "#process_image" do
      context "with a valid format" do
        it "processes and attaches an image" do
          file = fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "test.jpg"), "image/jpeg")
          subject.process_image(file)
          expect(subject.image).to be_attached
        end
      end

      context "whit an invalid format" do
        it "raise an error" do
          file = fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "wrong_format.avi"), "video/avi")
          expect { subject.process_image(file) }.to raise_error(Vips::Error)
        end
      end
    end

    xcontext ".categorized_wines" do
      # PENDING TO IMPLEMENT
      let!(:inactive_wine) { create(:wine, active: false) }
      let!(:wine1) { create(:wine, active: true, title: "Zwine", category_id: 1) }
      let!(:wine2) { create(:wine, active: true, title: "Awine", category_id: 1) }
      let!(:wine3) { create(:wine, active: true, title: "Bwine", category_id: 2) }

      it "returns only active wines" do
        expect(wine.categorized_wines.keys).not_to include(inactive_wine.category_id)
      end

      it "orders wines by title" do
        expect(wine.categorized_wines[wine1.category_id].first).to eq(wine2)
        expect(wine.categorized_wines[wine1.category_id].second).to eq(wine1)
      end

      it "groups wines by category_id" do
        expect(wine.categorized_wines[wine1.category_id].count).to eq(2)
        expect(wine.categorized_wines[wine3.category_id].count).to eq(1)
      end
    end
  end
end
