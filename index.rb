require 'json'
bookings = [
    {"@make":"Toyota","@model":"Corolla","@year":"2011","@colour":"White"},
    {"@make":"Nissan","@model":"Micra","@year":"2012","@colour":"Yellow"},

]
puts "What would you like to do?"
user_input = gets.chomp


class CarDetails
    attr_accessor :make, :model, :year, :pages
    def initialize (make, model, year, colour)
    @make = make
    @model = model
    @year = year
    @colour = colour
    end


    def add_booking
        puts "Make: "
        car_make = gets.chomp
        puts "Model: "
        car_model = gets.chomp
        puts "Year: "
        car_year = gets.chomp
        puts "Colour: "
        car_color = gets.chomp
        new_car = CarDetails.new(car_make, car_model, car_year, car_color)
        new_car = new_car.to_json
        bookings = bookings.push(new_car)
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

    def add_booking
        puts "Make: "
        car_make = gets.chomp
        puts "Model: "
        car_model = gets.chomp
        puts "Year: "
        car_year = gets.chomp
        puts "Colour: "
        car_color = gets.chomp
        new_car = CarDetails.new(car_make, car_model, car_year, car_color)
        new_car = new_car.to_json
        bookings = bookings.push(new_car)
    end


while user_input != "quit"
    case user_input
    when "add"
        puts "Make: "
        car_make = gets.chomp
        puts "Model: "
        car_model = gets.chomp
        puts "Year: "
        car_year = gets.chomp
        puts "Colour: "
        car_color = gets.chomp
        new_car = CarDetails.new(car_make, car_model, car_year, car_color)
        p new_car
        new_car = new_car.to_json
        bookings = bookings.push(new_car)
        break
    when "view"
        puts "Your current booking is: "
        bookings.each_with_index do |booking, index|
            puts "#{index+1}: #{booking}"
        end

  
    puts "What would you like to do?"
    user_input = gets.chomp


    when "delete"
        puts "what index would you like to delete?"
    end
end

puts "thank you for using our app"