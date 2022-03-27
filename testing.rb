class CarDetails
    def initialize (make, model, year, colour)
    @make = make
    @model = model
    @year = year
    @colour = colour
    end
end

car1 = CarDetails.new("Toyota", "Corolla", "2011", "White")
p car1