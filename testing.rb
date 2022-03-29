require 'json'
bookings = []
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

car1 = CarDetails.new("Toyota", "Corolla", "2011", "White")
car2 = CarDetails.new("Nissan", "Micra", "2012", "Yellow")


new_car1 = car1.to_json
bookings = bookings.push(new_car1)
new_car2 = car2.to_json
bookings = bookings.push(new_car2)

puts bookings[1]