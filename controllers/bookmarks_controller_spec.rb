require 'rails_helper'
begin
  require "bookmarks_controller"
rescue LoadError
end

if defined?(BookmarksController)
  RSpec.describe BookmarksController, type: :controller do

    before(:each) do
      @movie = Movie.create!(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic, 84 years later.")
      @list = List.create!(name: "Drama")
    end

    let(:valid_attributes) do
      { list_id: @list.id, bookmark: { movie_id: @movie.id, comment: "Great movie!" } }
    end

    let(:invalid_attributes) do
      { list_id: @list.id, bookmark: { movie_id: @movie.id, comment: "Good!" } }
    end

    describe "GET new" do
      it "assigns a new bookmark to @list" do
        get :new, params: valid_attributes
        expect(assigns(:bookmark)).to be_a_new(Bookmark)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new bookmark" do
          expect {
            post :create, params: valid_attributes
          }.to change(Bookmark, :count).by(1)
        end

        it "assigns a newly created bookmark as @bookmark" do
          post :create, params: valid_attributes
          expect(assigns(:bookmark)).to be_a(Bookmark)
          expect(assigns(:bookmark)).to be_persisted
        end

        it "redirects to the created list" do
          post :create, params: valid_attributes
          expect(response).to redirect_to(@list)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved bookmark as @bookmark" do
          post :create, params: invalid_attributes
          expect(assigns(:bookmark)).to be_a_new(Bookmark)
        end

        it "re-renders the 'new' template or 'lists/show'" do
          post :create, params: invalid_attributes
          expect(response).to render_template('new').or redirect_to(@list)
        end
      end
    end

    describe "DELETE destroy" do
      it "deletes a bookmark" do
        @bookmark = Bookmark.create!(valid_attributes[:bookmark].merge(list_id: @list.id))
        expect {
          delete :destroy, params: { id: @bookmark.id }
        }.to change(Bookmark, :count).by(-1)
      end
    end
  end
else
  describe "BookmarksController" do
    it "should exist" do
      expect(defined?(Bookmarks)).to eq(true)
    end
  end
end
