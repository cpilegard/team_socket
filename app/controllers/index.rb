$channel = EM::Channel.new

EventMachine.run do

    get '/' do
      erb :index
    end

    post '/' do
      $channel.push params[:message]
    end

    not_found do
    	@request = request.path_info
    	erb :not_found, layout: false
    end

    EventMachine::WebSocket.start(host: '0.0.0.0', port: 8080) do |ws|
      ws.onopen {
        subscriber = $channel.subscribe { |message| ws.send message }

        ws.onmessage do |message|
          $channel.push "#{subscriber} says: #{message}"
        end

        ws.onclose {
          $channel.unsubscribe(subscriber)
        }
      }
    end

end