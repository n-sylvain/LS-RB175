require "socket" 

server = TCPServer.new("localhost", 3003)

loop do 
  client = server.accept
  request_line = client.gets
  next if !request_line || request_line =~ /favicon/

  http_method, rest_of_http_request = request_line.split(" ")
  path, rest_of_http_request_2 = rest_of_http_request.split("?")
  params = rest_of_http_request_2.split("&").each_with_object({}) do |pair, hash|
    key, value = pair.split("=")
    hash[key] = value
  end

  client.puts "HTTP/1.0 200 OK"
  client.puts "Content-Type: text/html"
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  client.puts "<pre>"
  client.puts "the method is #{http_method}"
  client.puts "the path is #{path}"
  client.puts "The params are #{params}"
  client.puts "</pre>"

  rolls = params["rolls"].to_i
  sides = params["sides"].to_i

  rolls.times do 
    roll = rand(sides) + 1
    client.puts "You rolled a #{roll}. "
  end
  client.puts "</body>"
  client.puts "</html>"
  puts request_line 

  client.close
end