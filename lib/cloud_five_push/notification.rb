require 'httparty'
module CloudFivePush
  class Notification
    attr_accessor :user_identifiers, :alert, :message, :badge, :scheduled_at, :broadcast, :api_key

    include HTTParty
    base_uri 'https://www.cloudfiveapp.com'
    # debug_output $stderr

    def initialize(api_key=nil)
      @api_key = api_key || CloudFivePush.api_key
      if @api_key.nil?
        raise "api_key is required (or set CloudFivePush.api_key)"
      end
      @broadcast = false
      @user_identifiers = []
    end

    def notify!
      if blank_param?(@user_identifiers) && (@broadcast == false)
        raise "Please set user_identifiers or set broadcast=true"
      end
      if blank_param?(@alert) && blank_param?(@badge)
        raise "Please set alert or badge"
      end
      params = {
        api_key: @api_key,
        alert: @alert,
        badge: @badge
      }

      params[:message] = @message if @message
      params[:when] = @scheduled_at.iso8601 if @scheduled_at

      if @broadcast
        params[:audience] = "broadcast"
      else
        params[:user_identifiers] = @user_identifiers
      end

      self.class.post('/push/notify', body: params)
    end

    private

    def blank_param?(param)
      param.nil? || param.empty?
    end

  end
end
