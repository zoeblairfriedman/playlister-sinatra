class Artist < ActiveRecord::Base
    has_many :songs
    has_many :genres, through: :songs


    def self.find_by_slug(slug)
        words = slug.split("-")
        artist = words.map{|word|word.capitalize}.join(" ")
        Artist.find_by(name: artist)
    end

    def slug
        self.name.downcase.gsub(" ","-")
    end
end