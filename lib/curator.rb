class Curator
  attr_reader :photographs,
              :artists

  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photo)
    @photographs.push(photo)
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    # @artists.find do |artist|
    #   artist.id == id
    # end
    @artists.find_all do |artist|
      artist.id.include?(id)
    end[0]
    #
    # correct_artist =[]
    # @artists.each do |artist|
    #   if artist.id == id
    #     correct_artist << artist
    #   end
    # end
    # correct_artist[0]
  end

  def photographs_by_artist
    photos_hash = Hash.new
    @artists.map do |artist|
      photos_hash[artist] = @photographs.select {|photo| photo.artist_id == artist.id}
    end
    photos_hash
  end

  def artists_with_multiple_photographs
    photographs_by_artist
    photographs_by_artist.find_all do |key, value|
      return[key.name] if value.size > 1
    end
  end

  def photographs_taken_by_artists_from(country)
    photo_time = photographs_by_artist.find_all do |key, value|
      value if key.country == country
    end
    photo_time.flatten.select do |element|
      element.class == Photograph
    end
  end
end
