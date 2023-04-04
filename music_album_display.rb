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
      def list_all_albums
        if @albums.empty?
          puts 'No albums found! 🙁'
        else
          puts "***************** Album Information 🎧 ********************\n"
          @albums.each do |album|
            puts "--> Album title: #{album.name}\n--> Released year: #{album.publish_date.year}\n--> Music genre: #{album.genres}\n"
            puts "===========================================================\n"
          end
        end
      end
end