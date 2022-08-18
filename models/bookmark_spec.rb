require "rails_helper"

RSpec.describe "Bookmark", type: :model do
  let(:titanic) do
    Movie.create!(title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic, 84 years later.")
  end

  let :wonder_woman do
    Movie.create!(title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s")
  end

  let(:classic_list) do
    List.create!(name: "Classic Movies")
  end

  let(:comedy_list) do
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
    bookmark = Bookmark.new(comment: "Great movie!")
    expect(bookmark.comment).to eq("Great movie!")
  end

  it "comment cannot be shorter than 6 characters" do
    bookmark = Bookmark.new(comment: "Good", list: classic_list, movie: titanic)
    expect(bookmark).not_to be_valid
  end

  it "belongs to a movie" do
    bookmark = Bookmark.new(movie: titanic)
    expect(bookmark.movie).to eq(titanic)
  end

  it "belongs to an list" do
    bookmark = Bookmark.new(list: classic_list)
    expect(bookmark.list).to eq(classic_list)
  end

  it "movie cannot be blank" do
    attributes = valid_attributes
    attributes.delete(:movie)
    bookmark = Bookmark.new(attributes)
    expect(bookmark).not_to be_valid
  end

  it "list cannot be blank" do
    attributes = valid_attributes
    attributes.delete(:list)
    bookmark = Bookmark.new(attributes)
    expect(bookmark).not_to be_valid
  end

  it "is unique for a given movie/list couple" do
    Bookmark.create!(valid_attributes)

    bookmark = Bookmark.new(valid_attributes.merge(comment: "Award-winning"))
    expect(bookmark).not_to be_valid

    bookmark = Bookmark.new(valid_attributes.merge(list: comedy_list))
    expect(bookmark).to be_valid

    bookmark = Bookmark.new(valid_attributes.merge(movie: wonder_woman))
    expect(bookmark).to be_valid
  end
end
