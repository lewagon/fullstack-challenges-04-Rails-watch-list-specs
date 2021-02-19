require 'rails_helper'

RSpec.describe "Saved Movie", type: :model do
  let (:titanic) do
    Movie.create!(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic, 84 years later.")
  end

  let (:classic_list) do
    List.create!(name: "Classic Movies")
  end

  let (:comedy_list) do
    List.create!(name: "Comedy")
  end

  let(:valid_attributes) do
    {
      comment: "Great movie!",
      movie: titanic,
      list: classic_list
    }
  end

  it "has a comment" do
    saved_movie = SavedMovie.new(comment: "Great movie!")
    expect(saved_movie.comment).to eq("Great movie!")
  end

  it "comment cannot be shorter than 6 characters" do
    saved_movie = SavedMovie.new(comment: "Good", list: classic_list, movie: titanic)
    expect(saved_movie).not_to be_valid
  end

  it "belongs to a movie" do
    saved_movie = SavedMovie.new(movie: titanic)
    expect(saved_movie.movie).to eq(titanic)
  end

  it "belongs to an list" do
    saved_movie = SavedMovie.new(list: classic_list)
    expect(saved_movie.list).to eq(classic_list)
  end

  it "movie cannot be blank" do
    attributes = valid_attributes
    attributes.delete(:movie)
    saved_movie = SavedMovie.new(attributes)
    expect(saved_movie).not_to be_valid
  end

  it "list cannot be blank" do
    attributes = valid_attributes
    attributes.delete(:list)
    saved_movie = SavedMovie.new(attributes)
    expect(saved_movie).not_to be_valid
  end

  it "is unique for a given movie/list couple" do
    SavedMovie.create!(valid_attributes)
    saved_movie = SavedMovie.new(valid_attributes.merge(comment: "Award-winning"))
    expect(saved_movie).not_to be_valid

    saved_movie = SavedMovie.new(valid_attributes.merge(list: comedy_list))
    expect(saved_movie).to be_valid
  end
end
