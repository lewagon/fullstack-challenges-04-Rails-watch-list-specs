require 'rails_helper'
begin
  require "lists_controller"
rescue LoadError
end

if defined?(ListsController)
  RSpec.describe ListsController, type: :controller do
    let(:valid_attributes) do
      {
        name: "Comedy"
      }
    end

    let(:invalid_attributes) do
      { name: "" }
    end

    describe "GET index" do
      it "assigns all lists as @lists" do
        list = List.create! valid_attributes
        get :index, params: {}
        expect(assigns(:lists)).to eq([list])
      end
    end

    describe "GET show" do
      it "assigns the requested list as @list" do
        list = List.create! valid_attributes
        get :show, params: { id: list.to_param }
        expect(assigns(:list)).to eq(list)
      end
    end

    describe "GET new" do
      it "assigns a new list as @list" do
        get :new, params: {}
        expect(assigns(:list)).to be_a_new(List)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new List" do
          expect {
            post :create, params: { list: valid_attributes}
          }.to change(List, :count).by(1)
        end

        it "assigns a newly created list as @list" do
          post :create, params: { list: valid_attributes}
          expect(assigns(:list)).to be_a(List)
          expect(assigns(:list)).to be_persisted
        end

        it "redirects to the created list" do
          post :create, params: { list: valid_attributes}
          expect(response).to redirect_to(List.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved list as @list" do
          post :create, params: { list: invalid_attributes}
          expect(assigns(:list)).to be_a_new(List)
        end

        it "re-renders the 'new' template" do
          post :create, params: { list: invalid_attributes}
          expect(response).to render_template("new")
        end
      end
    end
  end

else
  describe "ListsController" do
    it "should exist" do
      expect(defined?(ListsController)).to eq(true)
    end
  end
end
