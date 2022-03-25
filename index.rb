puts "What would you like to do?"
user_input = gets.chomp

while user_input != "quit"
    if user_input == "add"
        puts "add new booking to the system"
        break
    elsif user_input == "view"
        puts "view current booking"
        break
    elsif user_input == "delete"
        puts "delete a item"
        break
    else
        puts "thank you for using our app"
    break
    end
end


