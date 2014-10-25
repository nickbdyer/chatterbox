def get_response(input)
  key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
  /#{key}/ =~ input
  response = RESPONSES[key]
  response.nil? ? 'sorry?' : response % { c1: $1, c2: $2, c3: $3, c4: $4, c5: $5}
end

RESPONSES = { 'goodbye' => 'bye', 
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

puts "Hello, what's your name?"
name = gets.chomp
puts "Hello #{name}"
while(input = gets.chomp) do
  if input == "quit" 
  	return exit
  else
  	puts get_response(input)
  end
end