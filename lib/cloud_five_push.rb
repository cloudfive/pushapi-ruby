require "cloud_five_push/version"
require "cloud_five_push/message"

module CloudFivePush
  @api_key = nil
  def self.api_key=(api_key)
    @api_key = api_key
  end

  def self.api_key
    @api_key
  end

  def self.broadcast!(message)
    m = CloudFivePush::Message.new
    m.broadcast = true
    m.message = message
    m.send!
  end
end
