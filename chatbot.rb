require 'CSV'

@RESPONSES = {}
@botprompt = 'BOT> '
@prompt = 'USER> '

def get_response(input)
  key = @RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
  /#{key}/ =~ input
  response = @RESPONSES[key]
  response.nil? ? "sorry?" : response % { c1: $1, c2: $2, c3: $3, c4: $4, c5: $5}
end

def intro
  puts "\e[31m#{@botprompt}Hello, what's your name?"
  print "\e[32m#{@prompt}"
  name = gets.chomp
  puts "\e[31m#{@botprompt} Hello #{name}"
end

def interact
  print "\e[32m#{@prompt}"
  while(input = gets.chomp) do
    if input == "quit" 
      puts "\e[0m"
    	return exit
    else
    	print "\e[31m#{@botprompt}", get_response(input), "\n"
      print "\e[32m#{@prompt}"
    end
  end
end


def save_responses(filename)
  # open the file for writing
  CSV.open(filename, "w") do |file|
  # iterate over the array of responses
    @RESPONSES.each do |k, v|
      response_data = ["#{k}", "#{v}"]
      file << response_data
    end
  end
  puts "File saved." 
end

def load_responses(filename)
  CSV.foreach(filename, "r") do |row|
      add_response(row[0], row[1])
  end
end


def add_response(phrase, response)
  @RESPONSES["#{phrase}"] = "#{response}"
end



def engine
  load_responses('responses.csv')
  intro
  interact
end

engine
