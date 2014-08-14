module FactoryGirl
  def self.build_stubbed_uuid(*args, &block)
    obj = build_stubbed(*args, &block)
    obj.id = SecureRandom.uuid
    obj
  end
end
