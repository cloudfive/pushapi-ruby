require 'httparty'
module CloudFivePush
  class Notification
    attr_accessor :user_identifiers, :alert, :message, :badge, :scheduled_at, :broadcast,
                  :api_key, :data, :aps_environment, :content_available

    include HTTParty
    base_uri 'https://push.cloudfiveapp.com'
    debug_output $stderr

    def initialize(api_key=nil)
      @api_key = api_key || CloudFivePush.api_key
      if @api_key.nil?
        raise "api_key is required (or set CloudFivePush.api_key)"
      end
      @broadcast = false
      @user_identifiers = []
      @aps_environment = CloudFivePush.aps_environment
    end

    def notify!
      if blank_param?(@user_identifiers) && !@broadcast
        raise "Please set user_identifiers or set broadcast=true"
      end

      if @broadcast && !blank_param?(@user_identifiers)
        raise "Can't both broadcast and set user_identifiers"
      end

      self.class.post('/push/notify', body: push_params)
    end

    def user_identifiers=(user_identifiers)
      @user_identifiers = [user_identifiers].flatten
    end
    alias user_identifier= user_identifiers=

    private

    def blank_param?(param)
      param.nil? || param.empty?
    end

    def push_params
      params = {
        api_key: @api_key
      }

      params[:alert] = @alert if @alert
      params[:badge] = @badge if @badge
      params[:message] = @message if @message
      params[:when] = @scheduled_at.iso8601 if @scheduled_at
      params[:data] = @data.to_json if @data
      params[:aps_environment] = @aps_environment.to_s if @aps_environment
      params[:content_available] = @content_available.to_s if @content_available

      if @broadcast
        params[:audience] = "broadcast"
      else
        params[:user_identifiers] = @user_identifiers
      end

      params
    end

  end
end
