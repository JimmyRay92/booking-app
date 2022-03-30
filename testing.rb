require 'json'
require 'oj'
bookings = [
    {"@make":"Toyota","@model":"Corolla","@year":"2011","@colour":"White"},
    {"@make":"Nissan","@model":"Micra","@year":"2012","@colour":"Yellow"},
    {:make => "Toyota",:model => "Corolla",:year => "2012",:colour => "White"}
]
class CarDetails
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
# def display_car_make()
#        puts "Your car is " + CarDetails.make  
# end

def get_car
    make = gets.chomp
    model = gets.chomp
    year = gets.chomp
    colour = gets.chomp
    car = puts "your car is Make: #{make}, Model: #{model}, Year : #{year}, Colour: #{colour}"
    return car
end



car1 = CarDetails.new("Toyota", "Corolla", "2011", "White")
car2 = CarDetails.new("Nissan", "Micra", "2012", "Yellow")
car3 = CarDetails.new("Nissan", "Patrol", "2010", "White")
p bookings

# p car1
# p car2
# p car3

# new_car1 = car1.to_json
# bookings = bookings.push(car1)
# new_car2 = car2.to_json
# bookings = bookings.push(car2)
# new_car3 = car3.to_json
# bookings << car3


# p bookings

p bookings