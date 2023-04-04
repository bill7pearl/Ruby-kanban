class MusicAlbumDisplay
    def initialize(filename)
        @filename = filename
        @albums = load_data || []
      end
end