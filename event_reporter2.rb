require "csv"
require "pry"

class EventReporter

  def initialize
    @queue = []
    printf "Enter Command: "
    queue_clear
    loop do
      input = gets.chomp.split(" ")
      process_input(input)
    end
  end

  def process_input (input)
    rest_of_input = input[1..-1]
    command = input[0]

    case command
    when "load" then load_csv(rest_of_input)
    when "help" then help_user(rest_of_input)
    when "queue" then queue(rest_of_input)
    when "find" then find(rest_of_input)
    when "quit" then quit_loop
    else
      puts "DOES NOT COMPUTE!!!"
    end
  end


  def quit_loop
    puts "Goodbye User!"
    exit 
  end

def load_file(filename)
    @data = EventAttendee.new(filename).get_attendees
    puts "Confirmation: #{filename} was successfully loaded"
    puts "There were #{@data.length} records retrieved"
  end

  def load_csv(filename)

    if filename.empty? 
      filename = "event_attendees.csv"
      puts "we're about to load file: #{filename}"
    else
      filename = filename[0]
      puts "In load_csv method after filename = filename[0]"
    end

    puts "Im after the load_csv method"

    if File.exist?(filename)

      @attendees = parse_csv(filename)
    else 
      puts "Couldn't Load File."
    end

  end

  def help_user(input)
    
    if input.join(" ") == "queue print"
      puts "Print out a tab-delimited data table with a header row following this format"
    elsif input.join(" ") == "load"
      puts "Erase any loaded data and parse the specified file. If no filename is given, default to csv file"
      elsif input.join(" ") == "queue clear"
        puts "Empty the queue"
      elsif input.join(" ") == "queue count"
      puts "Output how many records are in the current queue"
    elsif input.join(" ") == "queue save to event_attendees.csv"
      puts "Export the current queue to the specified filename as a CSV. The file should should include data and headers for last name, first name, email, zipcode, city, state, address, and phone number."
    elsif input.join(" ") == "queue print by <attribute>"
      puts "Print the data table sorted by the specified attribute like zipcode."

    else
      puts "No such command"
    end
  end


  def queue(input)
    puts "You have entered the queue.\nYour subcommand was: #{ input }"

    case input[0]
    when "count" then queue_count
    when "clear" then queue_clear
    when "print" then queue_print
    else
      puts "DOES NOT COMPUTE!!!"
    end
  end

  def queue_count
    puts "There are #{@queue.count} attendees"
  end

  def queue_clear
    @queue = []
  end

  def queue_print
   puts "LAST NAME\tFIRSTNAME\tEMAIL\tZIPCODE\tCITY\tSTATE\tADDRESS\tPHONE"
   @queue.each do |p|
    puts [p.last_name, p.first_name, p.email, p.zip, p.city, p.state, p.address, p.phone].join("\t")
  end
end

Attendee = Struct.new(:registration, :first_name, :last_name, :email,
 :phone, :address, :city, :state, :zip)

def parse_csv(filename)
  contents = CSV.open(filename, :headers => true, header_converters: :symbol)
  puts "parsing data"
  attendees = []
      # binding.pry
      contents.each do |line| 
        registration = line[:regDate]
        first_name = line[:first_Name]
        last_name = line[:last_Name]
        email = line[:email_Address] 
        phone = line[:homePhone]
        address = line[:street]
        city = line[:city]
        state = line[:state]
        zip = line[:zipcode]
        people = Attendee.new(registration, first_name, last_name, email, phone, address, city, state, zip)
        attendees << people
      end
      return attendees
    end
  end



  
  EventReporter.new
