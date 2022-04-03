begin
    require 'json'
    require 'tty-prompt'
    require 'rubocop'
    require 'rspec'
rescue LoadError
    puts 'There has been an error loading the necessary dependencies'
    puts "Please:
        1. navigate to the root directory of this application
        2. run the program again."
    exit!
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

class CarDetails
    attr_accessor :make, :model, :pages
    def initialize (make, model, colour)
    @make = make
    @model = model
    @colour = colour
    end
end

#     def to_json
#         hash = {}
#         self.instance_variables.each do |var|
#             hash[var] = self.instance_variable_get var
#         end
#         hash.to_json
#     end

#     def from_json! string
#         JSON.load(string).each do |var, val|
#             self.instance_variable_set var, val
#         end
#     end
# end


# def view_bookings
#     bookings.each_with_index do |booking, index|
#     puts "#{index+1}: #{booking}"
# end
bookings = JSON.load_file('bookings.json', symbolize_names: true)

def file_writing(book)
    File.write('bookings.json', JSON.pretty_generate(book))
end

def prints_view_information
    puts "Your current booking is:"
end

# def show_current_bookings
#     puts "you have #{bookings.length} bookings."
# end


loop do
    prompt = TTY::Prompt.new
    input = prompt.select("What would you like to do?", %w(view add delete exit)) 
    


    case input
    when "add"
        begin
            new_booking = prompt.collect do
                key(:make).ask("Enter a make?", required: true)

                key(:model).ask("Enter a model?", required: true)

                key(:colour).ask("Enter a colour?", required: true)
            end
            puts "you have added #{new_booking}"
            bookings << new_booking
            file_writing(bookings)
        rescue
            puts "unexcepted error"
            retry
        end
        
    when "view"
            if bookings.length == 0
                puts "You have no bookings left"
            else  
                prints_view_information
                bookings.each_with_index do |booking, index|
                    puts "#{index+1}: #{booking}"
                end
            end

    when "delete"
        begin
            puts "Select a index to delete: "
            index = gets.chomp.to_i
            if index <= 0
                puts "selection cannot be smaller than or equal to 0"
            elsif index > bookings.length
                puts "selection does not exist"
            else
            deleted = bookings.slice!(index - 1)
            puts "you have deleted #{deleted}"
            file_writing(bookings)
            end
        rescue 
            puts "wrong type, or answer cannot be empty"
            retry
        end
    when "exit"
        break
    end
end

rescue JSON::ParserError
    puts 'unexcepted error in json file'
rescue Interrupt
    puts ' You ended the program!'
rescue Errno::ENOENT
    puts 'Internal File Not Found'
end