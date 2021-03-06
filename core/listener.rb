class Listener
  attr_accessor :payload, :fired_actions
  def self.metaclass
    class << self
      self
    end
  end

  def initialize(payload)
    self.payload = payload
    callbacks = self.class.metaclass.callbacks # Copy callbacks into scope
    callbacks.each do |callback_hash|
      if callback_hash[:condition].call payload
        @fired_actions ||= []
        @fired_actions.push callback_hash[:name]
        callback_hash[:callback].call payload
      end
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

  def self.action(name, condition_method, &callback_method)
    metaclass.callbacks ||= []
    metaclass.callbacks.push condition: condition_method, callback: callback_method, name: name
  end

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end
end
