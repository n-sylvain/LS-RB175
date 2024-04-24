require "socket"

def parse_request(request_line)
  http_method, path_and_params, http = request_line.split(" ")
  path, params = path_and_params.split("?")

  # Check if params is nil before trying to split it
  params = (params || "").split("&").each_with_object({}) do |pair, hash|
    key, value = pair.split("=")
    hash[key] = value
  end

  [http_method, path, params]
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept

  request_line = client.gets
  # next if !request_line || request_line =~ /favicon/
  puts request_line

  next unless request_line

  http_method, path, params = parse_request(request_line)

  rolls = params["rolls"].to_i
  sides = params["sides"].to_i

  response_body = "<p>Request Line: #{request_line}</p>"
  response_body += "<p>HTTP Method: #{http_method}</p>"
  response_body += "<p>Path: #{path}</p>"
  response_body += "<p>Params: #{params.inspect}</p>"

  response_body += "<h1>Counter</h1>"

  number = params["number"].to_i
  response_body += "<p>The current number is #{number}.</p>"
  response_body += "<a href='?number=#{number + 1}'>Add one   </a>"
  response_body += "<a href='?number=#{number - 1}'>Substract one</a>"

  response = "HTTP/1.1 200 OK\r\n"
  response += "Content-Type: text/html\r\n"
  response += "Content-Length: #{response_body.length}\r\n"
  response += "\r\n"
  response += response_body

  client.print response
  client.close
end
