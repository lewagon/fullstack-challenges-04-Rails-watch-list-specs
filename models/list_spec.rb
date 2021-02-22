require 'rails_helper'

RSpec.describe "List", type: :model do
  let(:valid_attributes) do
    {
      name: "Comedy"
    }
  end

  let(:titanic) do
    Movie.create!(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic, 84 years later.")
  end

  it "has a name" do
    list = List.new(name: "Comedy")
    expect(list.name).to eq("Comedy")
  end

  it "name cannot be blank" do
    list = List.new
    expect(list).not_to be_valid
  end

  it "name is unique" do
    List.create!(name: "Comedy")
    list = List.new(name: "Comedy")
    expect(list).not_to be_valid
  end

  it "has many bookmarks" do
    list = List.new(valid_attributes)
    expect(list).to respond_to(:bookmarks)
    expect(list.bookmarks.count).to eq(0)
  end

  it "has many movies" do
    list = List.create!(valid_attributes)
    expect(list).to respond_to(:movies)
    expect(list.movies.count).to eq(0)

    list.bookmarks.create(list: list, movie: titanic, comment: "Great movie!")
    expect(list.movies.count).to eq(1)
  end

  it "should destroy child saved movies when destroying self" do
    list = List.create!(valid_attributes)
    list.bookmarks.create(list: list, movie: titanic, comment: "Great movie!")
    expect { list.destroy }.to change { Bookmark.count }.from(1).to(0)
  end
end
