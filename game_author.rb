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
    puts "Game '#{game.title}' has been added ✅"
    save_data
  end

  def add_author(author)
    return if authors.include?(author)

    authors << author
  end

  def list_games
    if games.empty?
      puts 'There are no games in the catalog 🙁'
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
      puts 'There are no authors in the catalog 🙁'
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
end
