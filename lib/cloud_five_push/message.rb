require 'httparty'
module CloudFivePush
  class Message
    attr_accessor :user_identifiers, :message, :badge, :scheduled_at, :broadcast, :api_key

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

    def send!
      if blank_param?(@user_identifiers) && (@broadcast == false)
        raise "Please set user_identifiers or set broadcast=true"
      end
      if blank_param?(@message) && blank_param?(@badge)
        raise "Please set message or badge"
      end
      params = {
        api_key: @api_key,
        alert: @message,
        badge: @badge
      }
      if @scheduled_at
        params[:when] = @scheduled_at.iso8601
      end

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