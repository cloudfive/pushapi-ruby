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

  @aps_environment = nil
  def self.aps_environment=(aps_environment)
    @aps_environment = aps_environment
  end

  def self.aps_environment
    @aps_environment
  end

  @dev_mode = false
  def self.dev_mode=(dev_mode)
    @dev_mode = dev_mode
  end

  def self.dev_mode
    @dev_mode
  end

  def self.broadcast!(alert, scheduled_at = nil)
    notification = CloudFivePush::Notification.new
    notification.broadcast = true
    notification.alert = alert
    notification.scheduled_at = scheduled_at
    notification.notify!
  end

  def self.notify!(alert, user_identifiers, scheduled_at = nil)
    notification = CloudFivePush::Notification.new
    notification.alert = alert
    notification.user_identifiers = user_identifiers
    notification.scheduled_at = scheduled_at
    notification.notify!
  end
end
