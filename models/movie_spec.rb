require 'rails_helper'

RSpec.describe "Movie", type: :model do
  let(:valid_attributes) do
    {
      title: "Titanic",
      overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic, 84 years later.",
      poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg",
      rating: 7.9
    }
  end

  it "has a title and an overview" do
    movie = Movie.new(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic, 84 years later.")
    expect(movie.title).to eq("Titanic")
    expect(movie.overview).to eq("101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic, 84 years later.")
  end

  it "title is unique" do
    Movie.create!(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic, 84 years later.")
    movie = Movie.new(title: "Titanic")
    expect(movie).not_to be_valid
  end

  it "title cannot be blank" do
    attributes = valid_attributes
    attributes.delete(:title)
    movie = Movie.new(attributes)
    expect(movie).not_to be_valid
  end

  it "overview cannot be blank" do
    attributes = valid_attributes
    attributes.delete(:overview)
    movie = Movie.new(attributes)
    expect(movie).not_to be_valid
  end

  it "has many bookmarks" do
    movie = Movie.new(valid_attributes)
    expect(movie).to respond_to(:bookmarks)
    expect(movie.bookmarks.count).to eq(0)
  end

  it "should not be able to destroy self if has bookmarks children" do
    movie = Movie.create!(valid_attributes)
    list = List.create!(name: "Drama")
    movie.bookmarks.create(list: list, comment: "Great movie!")

    expect { movie.destroy }.to raise_error(ActiveRecord::InvalidForeignKey)
  end
end
