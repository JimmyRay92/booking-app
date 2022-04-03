require './index'

describe CarDetails do
    subject(:new_car) {CarDetails.new("Toyota", "Camary", "Blue")}

    it 'can be instantiated' do 
        except(new_car).not_to be_nil
        except(new_car).not_to be_an_instance_of CarDetails
    end
    it 'returns the make' do
        except(new_car.name) to eq 'Toyota'
end

describe add_booking do
    it 'can a new booking' do
    except(add_booking) to be True
end

describe view_booking do
    it 'can view all bookings' do
end

describe delete_booking do
    it 'can delete all bookings' do
end
    
