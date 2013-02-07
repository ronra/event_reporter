require 'csv'
require 'sunlight'
require 'pry'


class EventReporter

      def initialize
      puts "WELCOME"
      loop do 
        input = gets.chomp.split(" ")
      process_input(input)
      end
      end

      def process_input(input)
      rest_of_input = input.pop
          case input[0]
          when "load" then load_csv(rest_of_input)
          when "help" then help_user(rest_of_input)
          when "queue" then queue (rest_of_input)
          when "find" then find (rest_of_input)
          when "quit" then quit_field
          else
            puts "WTF"
          end
      end

        def quit_field
          puts "Goodbye"
          exit
        end

      def load_csv(filename)
        if filename.empty?
          puts "Hey I need a filename"
          end
        elsif
          file = File.open(filename)
          contents = CSV.parse(file)
          parse_csv(contents)
        else
        end
          #rescue "File not found"
        end
    

      Attendee = Struct.new(:registration, :first_name, :last_name, :email, :phone, :address, :city, :state, :zip)

      def parse_csv(contents)

      attendees = []
      contents.ea ch do |line|
        first_name=line ["first_Name"]
        last_name= line ["last_Name"]
        end
      end




EventReporter.new
