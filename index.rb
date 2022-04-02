require 'json'
require 'tty-prompt'
require 'rubocop'
require 'rspec'

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
end

# car_makers_list = ["Toyota", "Honda", "Merecedes", "BMW", "Volkswagen"]

# class CarDetails
#     attr_accessor :make, :model, :pages
#     def initialize (make, model, colour)
#     @make = make
#     @model = model
#     @colour = colour
#     end

#     def add_booking
#         result = prompt.collect do
#         key(:Car).ask("Make?", required: true)

#         key(:Model).ask("Model", required: true)

#         key(:Colour).ask("Colour", required: true )
#     end

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

# bookings = [
#   {make: "Toyota", model: "Corolla", colour: "White"},
#   {make: "Nissan", model: "Micra", colour: "Yellow"},
# ]
class InvalidSelectionError < StandardError
    def message
        return "Selection must not be empty"
    end
end

loop do
    bookings = JSON.load_file('bookings.json', symbolize_names: true)
    prompt = TTY::Prompt.new(interrupt: :exit)
    input = prompt.select("What would you like to do?", %w(view add delete exit)) 
    

    case input
    when "add"
        new_booking = prompt.collect do
            key(:make).ask("Make?", required: true)

            key(:model).ask("Model?", required: true)

            key(:colour).ask("Colour?", required: true)
        end
        puts "you have added #{new_booking}"
        bookings << new_booking
        File.write('bookings.json', JSON.pretty_generate(bookings))
        
    when "view"
        puts "Your current booking is: "
        
        bookings.each_with_index do |booking, index|
            puts "#{index+1}: #{booking}"
        end

    when "delete"
        puts "Select a index to delete: "
        index = gets.chomp.to_i
        if index == 0
            puts "invalid selection"
        elsif index > bookings.length
            puts "item does not exist"
        else
        deleted = bookings.slice!(index - 1)
        puts "you have deleted #{deleted}"
        File.write('bookings.json', JSON.pretty_generate(bookings))
        end
        
    when "exit"
        break
    end
end


puts "thank you for using our app"