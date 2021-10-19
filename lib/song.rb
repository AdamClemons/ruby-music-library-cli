class Song
    
    extend Concerns::Findable

    attr_accessor :name, :genre
    attr_reader :artist

    @@all = []

    def initialize(name, artist=nil, genre=nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
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
        song = Song.new(name)
        song.save
        song
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def self.new_from_filename(filename)
        # binding.pry
        data = filename.split(" - ")
        artist = Artist.find_or_create_by_name(data[0])
        genre = Genre.find_or_create_by_name(data[2].gsub(".mp3",""))
        # song = Song.find_or_create_by_name(data[1])
        # song.genre = genre
        # song.artist = artist
        # song
        new(data[1], artist, genre)
    end

    def self.create_from_filename(filename)
        song = self.new_from_filename(filename)
        song.save        
    end

end