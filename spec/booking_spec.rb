require './index'

describe Car do
    subject(:new_car) {Car.new("Toyota", "Camary", "Blue")}

    it 'can be instantiated' do 
      except(new_car).not_to be_nil
      except(new_car).not_to be_an_instance_of CarDetails
    end
    it 'returns the make' do
      except(new_car.make) to eq 'Toyota'
end

describe add_booking do
    it 'can a new booking' do
    except(add_booking) to return new_booking
end

describe view_booking do
    it 'can view all bookings' do
      except(view_booking) to return @booking_list
end

describe delete_booking(index) do
    it 'can delete all bookings' do
      except(delete_booking)(1) to eq(booking_list)
end
    
