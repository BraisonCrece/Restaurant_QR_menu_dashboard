require "rails_helper"

RSpec.describe WineTypesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/wine_types").to route_to("wine_types#index")
    end

    it "routes to #new" do
      expect(get: "/wine_types/new").to route_to("wine_types#new")
    end

    it "routes to #show" do
      expect(get: "/wine_types/1").to route_to("wine_types#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/wine_types/1/edit").to route_to("wine_types#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/wine_types").to route_to("wine_types#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/wine_types/1").to route_to("wine_types#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/wine_types/1").to route_to("wine_types#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/wine_types/1").to route_to("wine_types#destroy", id: "1")
    end
  end
end
