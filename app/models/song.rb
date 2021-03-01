class Song < ActiveRecord::Base
    belongs_to :artist
    has_many :song_genres
    has_many :genres, through: :song_genres


    def self.find_by_slug(slug)
        words = slug.split("-")
        song = words.map{|word|word.capitalize}.join(" ")
        Song.find_by(name: song)
    end

    def slug
        self.name.downcase.gsub(" ","-")
    end
end