require "cloud_five_push/version"
require "cloud_five_push/notification"

module CloudFivePush
  @api_key = nil
  def self.api_key=(api_key)
    @api_key = api_key
  end

  def self.api_key
    @api_key
  end

  def self.broadcast!(alert)
    notification = CloudFivePush::Notification.new
    notification.broadcast = true
    notification.alert = alert
    notification.send!
  end
end
