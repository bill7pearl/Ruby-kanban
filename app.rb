require_relative 'book'
require_relative 'label'
require_relative 'book_methods'
require_relative 'music'
require_relative 'music_album_display'
require_relative 'game'
require_relative 'game_author'
require 'json'

class App
  def main_menu
    puts "Welcome to our catalog 👋\nSelect an option: 👉"
    options = [
      '--------------------------------------------------',
      '1 - Books catalog',
      '    *************************',
      '2 - Music albums catalog',
      '    *************************',
      '3 - Games catalog',
      '    *************************',
      '4 - Quit',
      '--------------------------------------------------'
    ]
    puts options
    option = gets.chomp.downcase
    case option
    when '1'
      book = BookMethods.new('./data/books.json')
      book.run
    when '2'
      album = MusicAlbumDisplay.new('./data/albums.json')
      album.run
    when '3'
      game = GameStore.new
      game.run

    when '4'
      puts 'Thanks for using our catalog 😘'
      nil
    else
      puts 'Invalid choice ❌! Please try again.'
      main_menu
    end
  end
end

app = App.new
app.main_menu
