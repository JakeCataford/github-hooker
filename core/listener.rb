class ConditionalCallback
  attr_accessor :condition, :callback
  def initialize(condition, callback)
    @condition = condition
    @callback = callback
  end

  def do
    if condition.call
      callback.call
    end
  end
end

class Listener

  def self.metaclass; class << self; self; end; end

  def initialize(payload)
    @payload = payload
    self.class.metaclass.callbacks.each do |callback|
      callback.do
    end
  end

  class << metaclass
    attr_accessor :callbacks, :accepted_events
  end

  def self.listen_to(*events)
    metaclass.accepted_events ||= []
    events.each do |event|
      metaclass.accepted_events.push event
    end
  end

  def self.accepted_events
    return metaclass.accepted_events
  end

  def self.on(condition, &callback)
    metaclass.callbacks ||= []
    metaclass.callbacks.push ConditionalCallback.new(condition, callback)
  end

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end
end
