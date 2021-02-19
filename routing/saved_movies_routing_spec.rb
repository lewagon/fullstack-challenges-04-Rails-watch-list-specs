require "rails_helper"

begin
  require "saved_movies_controller"
rescue LoadError
end

if defined?(ListsController)

  RSpec.describe ListsController, type: :routing do
    describe "routing" do

      it "routes to #new" do
        expect(get: "/lists/1/saved_movies/new").to route_to(controller: "saved_movies", action: "new", list_id: "1")
      end

      it "routes to #create" do
        expect(post: "/lists/1/saved_movies").to route_to(controller: "saved_movies", action: "create", list_id: "1")
      end

      it "routes to #destroy" do
        expect(delete: "/saved_movies/1").to route_to(controller: "saved_movies", action: "destroy", id: "1")
      end

    end
  end

end
