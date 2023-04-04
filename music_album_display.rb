class MusicAlbumDisplay
    def initialize(filename)
        @filename = filename
        @albums = load_data || []
      end
      
      def display_menu
        puts "Welcome! 👋😃\nChoose an option: 👉"
        puts '1. List all albums'
        puts '2. List all genres'
        puts '3. Add an album'
        puts '4. Quit'
      end
end