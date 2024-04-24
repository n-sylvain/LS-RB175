require "socket"

def parse_request(request_line)
  http_method, path_and_params, http = request_line.split(" ")
  path, params = path_and_params.split("?")

  # Check if params is nil before trying to split it
  if params
    params = params.split("&").each_with_object({}) do |pair, hash|
      key, value = pair.split("=")
      hash[key] = value
    end
  else
    params = {}
  end

  [http_method, path, params]
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept

  request_line = client.gets
  # next if !request_line || request_line =~ /favicon/
  puts request_line

  http_method, path, params = parse_request(request_line)

  rolls = params["rolls"].to_i
  sides = params["sides"].to_i

  # Include the random numbers in the response body
  response_body = "#{request_line}\r\n#{http_method}\r\n#{path}\r\n#{params}\r\n"
  rolls.times do
    roll = rand(sides) + 1
    response_body += "#{roll}\r\n"
  end

  response = "HTTP/1.1 200 OK\r\n"
  response += "Content-Type: text/plain\r\n"
  response += "Content-Length: #{response_body.length}\r\n"
  response += "\r\n"
  response += response_body

  client.print response
  client.close
end
