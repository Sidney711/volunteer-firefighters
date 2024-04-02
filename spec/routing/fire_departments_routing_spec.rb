require "rails_helper"

RSpec.describe FireDepartmentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/fire_departments").to route_to("fire_departments#index")
    end

    it "routes to #new" do
      expect(get: "/fire_departments/new").to route_to("fire_departments#new")
    end

    it "routes to #show" do
      expect(get: "/fire_departments/1").to route_to("fire_departments#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/fire_departments/1/edit").to route_to("fire_departments#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/fire_departments").to route_to("fire_departments#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/fire_departments/1").to route_to("fire_departments#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/fire_departments/1").to route_to("fire_departments#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/fire_departments/1").to route_to("fire_departments#destroy", id: "1")
    end
  end
end
