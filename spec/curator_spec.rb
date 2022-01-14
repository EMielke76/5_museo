require './lib/photograph'
require './lib/artist'
require './lib/curator'

RSpec.describe Curator  do
  let(:curator) {Curator.new}

  let(:photo_1) {Photograph.new({
                 id: "1",
                 name: "Rue Mouffetard, Paris (Boy with Bottles)",
                 artist_id: "1",
                 year: "1954"
                  })}

  let(:photo_2) {Photograph.new({
                 id: "2",
                 name: "Moonrise, Hernandez",
                 artist_id: "2",
                 year: "1941"
                  })}
  let(:photo_3) {Photograph.new({
                 id: "3",
                 name: "Identical Twins, Roselle, New Jersey",
                 artist_id: "3",
                 year: "1967"
                  })}

  let(:photo_4) {Photograph.new({
                 id: "4",
                 name: "Monolith, The Face of Half Dome",
                 artist_id: "3",
                 year: "1927"
                  })}

  let(:artist_1) {Artist.new({
                id: "1",
                name: "Henri Cartier-Bresson",
                born: "1908",
                died: "2004",
                country: "France"
                  })}

  let(:artist_2) {Artist.new({
                id: "2",
                name: "Ansel Adams",
                born: "1902",
                died: "1984",
                country: "United States"
                  })}

  let(:artist_3) {Artist.new({
                 id: "3",
                 name: "Diane Arbus",
                 born: "1923",
                 died: "1971",
                 country: "United States"
                  })}

  it 'exists' do
    expect(curator).to be_an_instance_of(Curator)
  end

  it 'has attributes' do

    expect(curator.photographs).to eq([])
    expect(curator.artists).to eq([])
  end

  it 'can add photographs' do
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    expect(curator.photographs).to eq([photo_1, photo_2])
  end

  it 'can add artists' do
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    expect(curator.artists).to eq([artist_1, artist_2])
  end

  it 'can find an artist by id' do
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    expect(curator.find_artist_by_id("1")).to eq(artist_1)
  end
  describe 'iteration III' do
    before :each do
      curator.add_artist(artist_1)
      curator.add_artist(artist_2)
      curator.add_artist(artist_3)

      curator.add_photograph(photo_1)
      curator.add_photograph(photo_2)
      curator.add_photograph(photo_3)
      curator.add_photograph(photo_4)
    end

    it 'collects photographs by artists' do
      expected = {
        artist_1 => [photo_1],
        artist_2 => [photo_2],
        artist_3 => [photo_3, photo_4]
      }

      expect(curator.photographs_by_artist).to eq(expected)
    end

    it 'can find an artist with multiple photographs' do
      expect(curator.artists_with_multiple_photographs).to eq(["Diane Arbus"])
    end

    it 'returns photos taken in a given coutnry' do

      expect(curator.photographs_taken_by_artists_from("United States")).to eq([photo_2, photo_3, photo_4])
      expect(curator.photographs_taken_by_artists_from("Argetina")).to eq([])
    end
  end
end
