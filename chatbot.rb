
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

def interact
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
end

@RESPONSES = { 'goodbye' => 'bye', 
              'sayonara' => 'sayonara', 
              'the weather is (.*)' => 'I hate it when it\'s %{c1}', 
              'I love (.*)' => 'I love %{c1} too', 
              'I groove to (.*) and (.*)' => 'I love %{c1} but I hate %{c2}',
              'Coding is (.*)' => 'I agree coding is %{c1}',
              'I enjoy learning new (.*) in ruby' => 'Learning new %{c1} in ruby is great!',
              'I start at Makers on (.*)' => 'No way, so do I!',
              'What are you doing tomorrow, I\'m (.*) ' => 'I\'m %{c1} too',
              'I learnt some thing about (.*) today!' => 'I already know about %{c1}', 
              'I have added (.*) more capture groups!' => 'What are you going to do with %{c1} more capture groups?',
              'For lunch I am having a salad with (.*), (.*), (.*), (.*) and (.*)' => 'I like %{c2} and %{c3}, but hate %{c1}, %{c4} and %{c5}!',
               }

def save_responses(filename)
  # open the file for writing
  File.open(filename, "w") do |file|
  # iterate over the array of responses
    @RESPONSES.each do |k, v|
      response_data = ["#{k}", "#{v}"]
      file << response_data
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
  load_responses(responses.rb)
  intro
  get_response
end

save_responses('responses.rb')

