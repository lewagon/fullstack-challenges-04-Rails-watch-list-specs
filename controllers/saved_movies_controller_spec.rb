require 'rails_helper'
begin
  require "saved_movies_controller"
rescue LoadError
end

if defined?(SavedMoviesController)
  RSpec.describe SavedMoviesController, type: :controller do

    before(:each) do
      @movie = Movie.create!(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic, 84 years later.")
      @list = List.create!(name: "Drama")
    end

    let(:valid_attributes) do
      { list_id: @list.id, saved_movie: { movie_id: @movie.id, comment: "Great movie!" } }
    end

    let(:invalid_attributes) do
      { list_id: @list.id, saved_movie: { movie_id: @movie.id, comment: "Good!" } }
    end

    describe "GET new" do
      it "assigns a new saved movie to @list" do
        get :new, params: valid_attributes
        expect(assigns(:saved_movie)).to be_a_new(SavedMovie)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new saved movie" do
          expect {
            post :create, params: valid_attributes
          }.to change(SavedMovie, :count).by(1)
        end

        it "assigns a newly created saved movie as @saved_movie" do
          post :create, params: valid_attributes
          expect(assigns(:saved_movie)).to be_a(SavedMovie)
          expect(assigns(:saved_movie)).to be_persisted
        end

        it "redirects to the created list" do
          post :create, params: valid_attributes
          expect(response).to redirect_to(@list)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved saved movie as @saved_movie" do
          post :create, params: invalid_attributes
          expect(assigns(:saved_movie)).to be_a_new(SavedMovie)
        end

        it "re-renders the 'new' template or 'lists/show'" do
          post :create, params: invalid_attributes
          expect(response).to render_template('new').or redirect_to(@list)
        end
      end
    end

    describe "DELETE destroy" do
      it "deletes a saved movie" do
        @saved_movie = SavedMovie.create!(valid_attributes[:saved_movie].merge(list_id: @list.id))
        expect {
          delete :destroy, params: { id: @saved_movie.id }
        }.to change(SavedMovie, :count).by(-1)
      end
    end
  end
else
  describe "SavedMoviesController" do
    it "should exist" do
      expect(defined?(SavedMoviesController)).to eq(true)
    end
  end
end
