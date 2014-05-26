class SampleListener < Listener
  listen_to :push

  on lambda{true} do
    puts "something"
  end
end
