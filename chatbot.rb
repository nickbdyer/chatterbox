
def get_response(input)
  key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
  /#{key}/ =~ input
  response = RESPONSES[key]
  response.nil? ? "sorry?" : response % { c1: $1, c2: $2, c3: $3, c4: $4, c5: $5}
end

@botprompt = 'BOT> '
prompt = 'USER> '

def intro
  puts "\e[31m#{@botprompt}Hello, what's your name?"
  print "\e[32m#{prompt}"
  name = gets.chomp
  puts "\e[31m#{@botprompt} Hello #{name}"
end


print "\e[32m#{prompt}"
while(input = gets.chomp) do
  if input == "quit" 
    puts "\e[0m"
  	return exit
  else
  	print "\e[31m#{@botprompt}", get_response(input), "\n"
    print "\e[32m#{prompt}"
  end
end


def choose_file
  puts "Please enter the name of the file you want to use, press return to use default:"
  filename = STDIN.gets.chomp + ".csv"
  filename == ".csv" ? filename = "students.csv" : filename
end


def save_students(filename)
  # open the file for writing
  File.open(filename, "w") do |file|
  # iterate over the array of students
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      file << student_data
    end
  end
  puts "File saved." 
end

def load_responses(filename)
  File.open(filename, "r") do |row|
      add_student(row[0], row[1])
  end
end


def add_response(phrase, response)
  @RESPONSES << {phrase => response}
end



def engine
  load_responses
  intro
  get_response
end

engine

