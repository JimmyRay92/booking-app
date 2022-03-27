class CarDetails
    attr_accessor :make, :model, :year, :pages
    def initialize (make, model, year, colour)
    @make = make
    @model = model
    @year = year
    @colour = colour
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
    p car1
        break

#     elsif user_input == "view"
#         puts "view current booking"
#         break
#     elsif user_input == "delete"
#         puts "delete a item"
#         break
#     else
#         puts "thank you for using our app"
#     break
    end
end


