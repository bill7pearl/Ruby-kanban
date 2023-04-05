require 'json'
require_relative 'book'
require_relative 'app'

class BookMethods
  def initialize(filename)
    @filename = filename
    @books = load_data || []
  end

  def display_menu
    puts "Welcome! 👋😃\nChoose an option: 👉"
    puts '1. List all books'
    puts '2. List all labels'
    puts '3. Add a book'
    puts '4. Exit'
  end
  
  def list_books
    if @books.empty?
      puts 'No books found!🙁'
    else
      puts "**************** Books Information 📕 *******************\n"
      @books.each do |book|
        puts "--> Book ID: #{book.id}\n--> Publisher: #{book.publisher}\n--> Cover State: #{book.cover_state}\n--> Archived: #{book.archived}\n"
         puts "==========================================================="
      end
    end
  end

  def list_labels
    labels = @books.map(&:labels).flatten.uniq
    if labels.empty?
      puts 'No labels found'
    else
      puts "********************* All Labels **********************\n"
      labels.each do |label|
        puts "--> Title: #{label.title}\n--> Color: #{label.color}"
        puts "===========================================================\n"
      end
    end
  end
  
  def add_book
    puts 'Enter book publisher:'
    publisher = gets.chomp
    puts 'Enter cover state (good/bad):'
    cover_state = gets.chomp
  
    labels = []
    puts 'Do you want to add a label for this book? (y/n)'
    choice = gets.chomp.downcase
    if choice == 'y'
      puts 'Enter label title:'
      title = gets.chomp
      puts 'Enter label color:'
      color = gets.chomp
      label = Label.new(title, color)
      labels << label
    end
    book = Book.new(publisher, cover_state, labels: labels)
    @books << book
    puts "Added #{book.publisher}."
    save_data
  end  
  
  def run
    app = App.new
    loop do
      display_menu
      option = gets.chomp.to_i
      case option
      when 1
        list_books
      when 2
        list_labels
      when 3
        add_book
      when 4
        print 'Thanks for using 😘'
        puts "\n"
        return app.main_menu
      else
        puts 'Ooops!!! Invalid option ❌'
        return main_menu
      end      
    end
  end

  private
  
  def load_data
    if File.exist?(@filename)
      begin
        data = JSON.parse(File.read(@filename))
        data.map do |book_data|
          label = Label.new(book_data['title'], book_data['color'])
          Book.new(
            book_data['publisher'],
            book_data['cover_state'],
            labels: [label],
            archived: book_data['archived'] || false,
            id: book_data['id'] || nil
          )
        end
      rescue JSON::ParserError => e
        puts "Error loading data: #{e.message}"
        []
      end
    else
      []
    end
  end
  
  def save_data
    File.write(@filename, JSON.generate(@books.map do |book|
      {
        'publisher' => book.publisher,
        'cover_state' => book.cover_state,
        'labels' => book.labels.map(&:to_h),
        'archived' => book.archived,
        'id' => book.id
      }
    end))
  end
end
