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
                key(:make).ask("Enter a make?", required: true)

                key(:model).ask("Enter a model?", required: true)

                key(:colour).ask("Enter a colour?", required: true)

describe add_booking do
    
