def get_response(input)
  key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
  /#{key}/ =~ input
  response = RESPONSES[key]
  response.nil? ? 'sorry?' : response % { c1: $1, c2: $2}
end

RESPONSES = { 'goodbye' => 'bye', 
              'sayonara' => 'sayonara', 
              'the weather is (.*)' => 'I hate it when it\'s %{c1}', 
              'I love (.*)' => 'I love %{c1} too', 
              'I groove to (.*) and (.*)' => 'I love %{c1} but I hate %{c2}'
          	  'Coding is (.*)' => 'I agree coding is %{c1}',
          	  'I enjoy learning new (.*) in ruby' => 'Learning new %{c1} in ruby is great!',
          	  'I start at Makers on (.*)' => 'No way, so do I!',
          	  'What are you doing tomorrow, I\'m (.*) ' => 'I\'m %{c1} too',
          	  'I learnt some thing about (.*) today!' => 'I already know about %{c1}' }

puts "Hello, what's your name?"
name = gets.chomp
puts "Hello #{name}"
while(input = gets.chomp) do
  puts get_response(input)
end