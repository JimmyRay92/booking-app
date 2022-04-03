begin
  require 'json'
  require 'tty-prompt'
  require 'rubocop'
  require 'rspec'
  require 'colorize'
rescue LoadError
    puts 'There has been an error loading the necessary dependencies'
    puts "Please:
        1. navigate to the root directory of this application
        2. run the program again."
    exit!
end

class CarDetails
    attr_accessor :make, :model, :pages
    def initialize (make, model, colour)
    @list = []
    @make = make
    @model = model
    @colour = colour
    end

    def to_json
        hash = {}
        self.instance_variables.each do |var|
            hash[var] = self.instance_variable_get var
        end
        hash.to_json
    end

    def from_json! string
        JSON.load(string).each do |var, val|
            self.instance_variable_set var, val
        end
    end
end

def file_writing(book)
    File.write('bookings.json', JSON.pretty_generate(book))
end

def prints_view_information
    puts "Your current booking is:"
end

begin
    # CLI arguments
    arguments = ARGV
    case
    when ( arguments & ['--h', '--help']).any?
        File.foreach('./help.txt') do |line|
            puts line
        end
        exit
    when (arguments & ['--a', '--about']).any?
        File.foreach('./help.txt') do |line|
            puts line
        end
        exit
    when (arguments & ['--g', '--gems']).any?
        File.foreach('./Gemfile') do |line|
            if line.include?('gem')
                puts line
            end
        end
        exit
    end

puts ("Welcome to the booking app!").colorize(:green)

loop do
    prompt = TTY::Prompt.new
    input = prompt.select("What would you like to do? Select exit to exit out of the app.", %w(view add delete exit))
    bookings = JSON.load_file('bookings.json', symbolize_names: true)
    


    case input
    when "add"
        begin
            new_booking = prompt.collect do
                key(:make).ask("Enter a make?".colorize(:light_blue), required: true)

                key(:model).ask("Enter a model?".colorize(:light_blue), required: true)

                key(:colour).ask("Enter a colour?".colorize(:light_blue), required: true)
            end
            puts "you have added #{new_booking}"
            bookings << new_booking
            file_writing(bookings)
        rescue NameError
            puts ("There may be a problem loading the json file, please restart the program").colorize(:red)
        rescue SyntaxError
            puts ("There may be a problem with the file, please restart the program").colorize(:red)
        end
        
    when "view"
        begin
            if bookings.length == 0
                puts "You have no bookings left"
            else  
                prints_view_information
                bookings.each_with_index do |booking, index|
                    puts ("#{index+1}: #{booking}").colorize(:light_blue)
                end
            end
        rescue NameError
            puts ("There may be a problem loading the json file, please restart the program").colorize(:red)
        end

    when "delete"
        begin
            puts "Select a index to delete: "
            index = gets.chomp.to_i
            if index <= 0
                puts ("selection cannot be smaller than or equal to 0").colorize(:red)
            elsif index > bookings.length
                puts ("selection does not exist").colorize(:red)
            else
            deleted = bookings.slice!(index - 1)
            puts "you have deleted #{deleted}"
            file_writing(bookings)
            end
        rescue 
            puts ("index cannot be empty").colorize(:red)
            retry
        end
    when "exit"
        break
    end
end

rescue JSON::ParserError
    puts ('unexcepted error in json file, please restart the program').colorize(:red)
rescue Interrupt
    puts (' You ended the program!').colorize(:red)
rescue Errno::ENOENT
    puts ('Internal File Not Found').colorize(:red)
end