begin
  require 'json'
  require 'tty-prompt'
  require 'rubocop'
  require 'rspec'
  require 'colorize'
rescue LoadError
  puts 'There has been an error loading the necessary dependencies'
  puts "Please:
        1. navigate to the root directory of this application
        2. run the program again."
  exit!
end

# Car class for a new booking
class Car
  attr_accessor :make, :model, :pages

  def initialize(make, model, colour)
    @booking_list = []
    @make = make
    @model = model
    @colour = colour
  end

  def add_booking
    puts 'Make?'
    make = gets.chomp
    puts 'Model?'
    model = gets.chomp
    puts 'Colour?'
    colour = gets.chomp
    new_booking = Car.new(make, model, colour)
  end

  def view_booking
    puts @booking_list
  end

  def delete_booking(index)
    del = @booking_list.delete(index)
  end
end

def file_writing(book)
  File.write('bookings.json', JSON.pretty_generate(book))
end

def prints_view_information
  puts 'Your current booking is:'
end

def prints_no_booking
  puts 'You have no bookings left'
end

begin
  # ARGV arguments
  arguments = ARGV
  case
  when (arguments & ['--h', '--help']).any?
    File.foreach('./help.txt') do |line|
      puts line
    end
    exit
  when (arguments & ['--a', '--about']).any?
    File.foreach('./help.txt') do |line|
      puts line
    end
    exit
  when (arguments & ['--g', '--gems']).any?
    File.foreach('./Gemfile') do |line|
      if line.include?('gem')
        puts line
    end
    end
    exit
  end

  puts ('Welcome to the booking app!').colorize(:green)

  loop do
    prompt = TTY::Prompt.new
    input = prompt.select('What would you like to do? Select exit to exit out of the app', %w(view add delete exit))
    bookings = JSON.load_file('bookings.json', symbolize_names: true)
    case input
    when 'add'
      begin
        new_booking = prompt.collect do
          key(:make).ask('Enter a make?'.colorize(:light_blue), required: true)

          key(:model).ask('Enter a model?'.colorize(:light_blue), required: true)

          key(:colour).ask('Enter a colour?'.colorize(:light_blue), required: true)
        end
        puts "you have added #{new_booking}"
        bookings << new_booking
        file_writing(bookings)
      rescue NameError
        puts ('There may be a problem loading the json file, please restart the program').colorize(:red)
      rescue SyntaxError
        puts ('There may be a problem with the file, please restart the program').colorize(:red)
      end

    when 'view'
      begin
        if bookings.length.zero?
          prints_no_booking
        else
          prints_view_information
          bookings.each_with_index do |booking, index|
            puts ("#{index + 1}: #{booking}").colorize(:light_blue)
          end
        end
      rescue TypeError
        puts ('invalid type').colorize(:red)
      rescue NameError
        puts ('here may be a problem loading the json file, please restart the program').colorize(:red)
      end

    when 'delete'
      begin
        puts 'Select a index to delete: '
        index = gets.chomp.to_i
        if index <= 0
          puts ('selection cannot be smaller than or equal to 0').colorize(:red)
        elsif index > bookings.length
          puts ('selection does not exist').colorize(:red)
        else
          deleted = bookings.slice!(index - 1)
          puts "you have deleted #{deleted}"
          file_writing(bookings)
        end
      rescue IndexError
        puts ('index does not exist').colorize(:red)
      rescue TypeError
        puts ('invalid selection').colorize(:red)
        retry
      end
    when 'exit'
      break
    end
  end
rescue JSON::ParserError
  puts ('unexcepted error in json file, please restart the program').colorize(:red)
rescue Interrupt
  puts (' You ended the program!').colorize(:red)
rescue Errno::ENOENT
  puts ('Internal File Not Found').colorize(:red)
end
