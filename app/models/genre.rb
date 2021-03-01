class Genre < ActiveRecord::Base
    has_many :song_genres
    has_many :songs, through: :song_genres
    has_many :artists, through: :songs

    def self.find_by_slug(slug)
        words = slug.split("-")
        genre = words.map{|word|word.capitalize}.join(" ")
        Genre.find_by(name: genre)
    end

    def slug
        self.name.downcase.gsub(" ","-")
    end
end

