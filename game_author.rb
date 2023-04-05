require 'json'
require_relative 'game'
require_relative 'author'
require_relative 'app'

class GameStore
  attr_reader :games, :authors

  def initialize
    @games = []
    @authors = []
  end

  def add_game(game)
    @games << game
    game.authors.each { |author| add_author(author) }
    puts "Game '#{game.title}' has been added."
    save_data
  end

  def add_author(author)
    return if authors.include?(author)

    authors << author
  end

  def list_games
    if games.empty?
      puts 'There are no games in the catalog.'
    else
      puts "***************** Games Information 🎮 ********************\n"
      games.each do |game|
        puts "Game ID: #{game.id}"
        puts "Title: #{game.title}"
        puts "Multiplayer: #{game.multiplayer ? 'Yes' : 'No'}"
        puts "Last Played At: #{game.last_played_at}"
        puts "Publish Date: #{game.publish_date}"
        puts "Authors: #{game.authors.map(&:full_name).join(', ')}"
        puts '-' * 50
      end
    end
  end

  def list_authors
    if authors.empty?
      puts 'There are no authors in the catalog.'
    else
      puts "***************** Author Information 🧑‍🏫 ********************\n"
      authors.each do |author|
        puts "Author ID: #{author.id}"
        puts "Name: #{author.full_name}"
        puts "Items: #{author.items.map(&:title).join(', ')}"
        puts '-' * 50
      end
    end
  end

  def save_data
    return unless File.exist?('./data/games.json') && File.exist?('./data/authors.json')

    File.write('./data/games.json', JSON.generate(games.map(&:to_hash)))
    File.write('./data/authors.json', JSON.generate(authors.map(&:to_hash)))
  end

  def load_data
    return unless File.exist?('./data/games.json') && File.exist?('./data/authors.json')

    games_data = JSON.parse(File.read('./data/games.json'), object_class: Game)
    authors_data = JSON.parse(File.read('./data/authors.json'), object_class: Author)

    @games = games_data.map do |game_data|
      game = Game.new(game_data['title'], game_data['multiplayer'], game_data['last_played_at'], game_data['publish_date'])
      game_data['authors'].each do |author_data|
        author = Author.new(author_data['first_name'], author_data['last_name'])
        game.add_author(author)
      end
      game
    end

    @authors = authors_data
  end

  def run
    app = App.new
    loop do
      puts "Welcome! 👋😃\nChoose an option: 👉"
      puts '1. List all games'
      puts '2. List all authors'
      puts '3. Add game'
      puts '4. Quit'
      choice = gets.chomp.to_i
      case choice
      when 1
        list_games
      when 2
        list_authors
      when 3
        puts 'Enter game title:'
        title = gets.chomp
        puts 'Is the game multiplayer? (Y/N)'
        multiplayer = gets.chomp.downcase == 'y'
        puts 'Enter the date of the last time the game was played (YYYY/MM/DD):'
        last_played_at = gets.chomp
        puts 'Enter the game\'s publish date (YYYY/MM/DD):'
        publish_date = gets.chomp
        game = Game.new(title, multiplayer, last_played_at, publish_date, [])
        puts 'Enter author first name:'
        first_name = gets.chomp
        puts 'Enter author last name:'
        last_name = gets.chomp
        author = Author.new(first_name, last_name)
        game.add_author(author)
        add_game(game)
      when 4
        save_data
        print 'Thanks for using our catalog 😘'
        puts "\n"
        return app.main_menu
      else
        puts 'Ooops!!! Invalid option ❌'
        return run
      end
    end
  end  
end
