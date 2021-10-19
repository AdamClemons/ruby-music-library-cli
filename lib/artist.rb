class Artist
    
    extend Concerns::Findable

    attr_accessor :name

    @@all = []

    def initialize(name)
        @name = name
    end

    def save
        @@all << self
    end

    def self.all
        @@all
    end

    def self.destroy_all
        self.all.clear
    end

    def self.create(name)
        artist = Artist.new(name)
        artist.save
        artist
    end

    def add_song(song)
        song.artist = self if song.artist == nil      
    end

    def songs
        Song.all.select{|song| song.artist == self}
    end

    def genres
        self.songs.map{|song| song.genre}.uniq        
    end
end