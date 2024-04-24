require "socket"

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept

  request_line = client.gets
  # next if !request_line || request_line =~ /favicon/
  puts request_line

  response = "HTTP/1.1 200 OK\r\n"
  response += "Content-Type: text/plain\r\n"
  response += "Content-Length: #{request_line.length}\r\n"
  response += "\r\n"
  response += request_line

  client.puts response
  client.close
end
