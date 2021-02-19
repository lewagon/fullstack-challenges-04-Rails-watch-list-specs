require "rails_helper"

begin
  require "lists_controller"
rescue LoadError
end

if defined?(ListsController)

  RSpec.describe ListsController, type: :routing do
    describe "routing" do

      it "routes to #index" do
        expect(get: "/lists").to route_to("lists#index")
      end

      it "routes to #new" do
        expect(get: "/lists/new").to route_to("lists#new")
      end

      it "routes to #show" do
        expect(get: "/lists/1").to route_to("lists#show", id: "1")
      end

      it "routes to #create" do
        expect(post: "/lists").to route_to("lists#create")
      end

    end
  end

end
