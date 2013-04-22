require 'faye'

API_KEY  = ENV['BOUNDARY_API_KEY']
ORG_ID   = ENV['BOUNDARY_ORG_ID']
TIME_SYNC =  { 'tc' => (Time.now.to_f * 1000.0).to_i,
               'l'  => 0,
               'o'  => 0 }
channel  = "/query/#{ORG_ID}/#{ENV['BOUNDARY_QUERY']}"
endpoint = 'https://ws.boundary.com/streaming'

class ClientAuth

  def outgoing(message, callback)
    return callback.call(message) unless message['channel'] == '/meta/handshake'

    message['ext'] ||= {}
    message['ext']['authentication_v2'] = { 'org_id' => ORG_ID,
                                            'token'  => API_KEY }

    callback.call message
  end

end

class TimeSync

  def outgoing(message, callback)
    message['ext'] ||= {}
    message['ext']['timesync'] = TIME_SYNC
    callback.call message
  end

end

EM.run {
  puts "Connecting to #{endpoint}"
  client = Faye::Client.new endpoint

  client.add_extension(ClientAuth.new)
  client.add_extension(TimeSync.new)

  client.handshake do |handshake|

    puts "Our client id is #{client.client_id}"

    puts "Going to subscribe to #{channel}"
    subscription = client.subscribe(channel) do |message|
      puts 'Got a message:'
      puts message.inspect
    end

    subscription.callback { puts "Subscribed to #{channel}" }
    subscription.errback { |error| puts "Unable to subscribe #{error.inspect}" }
  end

  client.bind 'transport:down' do
    puts "Connection to #{endpoint} down"
  end

  client.bind 'transport:up' do
    puts "Connected to #{endpoint}"
  end
}
