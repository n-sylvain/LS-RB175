require "socket" # Includes the socket library, part of standard Ruby, which includes some classes that we can use to create/interact with servers and do other networking tasks.

server = TCPServer.new("localhost", 3003) # Here we create a TCP server (TCP being the protocol/layer directly beneath HTTP - it's just how 2 computers talk to each other). We're creating a server on "localhost", which means the server will accept requests to "localhost". The port will be 3003, a 'non-standard' port so we don't have 2 channels talking to the same port.
loop do 
  client = server.accept # waits until soemone tries to request something from the server. So the loop is running until the server.accept call accepts the call and opens a connection to the client and returns a client object that we can play around with.

  request_line = client.gets # takes the first line of the request. The request is just all the text sent by the client to the server.
  puts request_line # prints to the console

  client.puts request_line # prints in the web browser
  client.close
end