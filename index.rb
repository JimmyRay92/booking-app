require 'json'

class CarDetails
    attr_accessor :make, :model, :year, :pages
    def initialize (make, model, year, colour)
    @make = make
    @model = model
    @year = year
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





puts "What would you like to do?"
user_input = gets.chomp
car_details = []
customer_details = []


while user_input != "quit"
    if user_input == "add"
    puts "Enter your make: "
    car_make = gets.chomp
    puts "Enter your model: "
    car_model = gets.chomp
    puts "Enter car year: "
    car_year = gets.chomp
    puts "Enter your car color: "
    car_color = gets.chomp
    car1 = CarDetails.new(car_make, car_model, car_year, car_color)
    File.open("booking.txt", "a") do |file|
        file.write(car1.to_json)
    end
    puts car1.to_json
        break

    elsif user_input == "view"
        puts "Your current booking is: "
        File.open("booking.txt", "r") do |file|
            puts file.read()
    end
        break


#     elsif user_input == "delete"
#         puts "delete a item"
#         break
#     else
#         puts "thank you for using our app"
#     break
    end
end


