require "rails_helper"

begin
  require "bookmarks_controller"
rescue LoadError
end

if defined?(ListsController)

  RSpec.describe ListsController, type: :routing do
    describe "routing" do

      it "routes to #new" do
        expect(get: "/lists/1/bookmarks/new").to route_to(controller: "bookmarks", action: "new", list_id: "1")
      end

      it "routes to #create" do
        expect(post: "/lists/1/bookmarks").to route_to(controller: "bookmarks", action: "create", list_id: "1")
      end

      it "routes to #destroy" do
        expect(delete: "/bookmarks/1").to route_to(controller: "bookmarks", action: "destroy", id: "1")
      end

    end
  end

end
