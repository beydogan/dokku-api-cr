require "socket"
require "json"

class Command
  def initialize(command : String, params : Array(String))
    @command = command
    @params = params
  end

  def run
    client = UNIXSocket.new("/var/run/dokku-daemon/dokku-daemon.sock")

    client.puts full_command
    response = parse_response(client.gets.to_s)
    client.close
    return response
  end

  def parse_response(response)
    return JSON.parse(response)
  end

  def full_command
    return @command + " " + @params.join(" ")
  end
end
