class App
    def main_menu
        app = App.new
        puts "Welcome to our catalog 👋\nSelect an option: 👉"
        options = [
          '+++++++++++++++++++++++++++++++++++++++++++++++',
          '1 - List books options',
          '***********************************************',
          '2 - List music options',
          '***********************************************',
          '3 - List game options',
          '***********************************************',
          '4 - Quit',
          '+++++++++++++++++++++++++++++++++++++++++++++++',
        ]
        puts options
        option = gets.chomp.downcase
    end
end

app = App.new
app.main_menu