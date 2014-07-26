# CloudFivePush

Dead simple push notifications.  This rubygem is just a very simple wrapper around the Cloud Five push notification API.  With it (and an account on http://cloudfiveapp.com), you can painlessly schedule push notifications to android and ios devices from your server.

## Installation

Add this line to your application's Gemfile:

    gem 'cloud_five_push'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cloud_five_push

## Usage

Global configuration: 
  
    CloudFivePush.api_key = "my_api_key"

Sending a notification immediately to all your users: 

    CloudFivePush.broadcast! "Hello from Cloud Five!"

Send a notification to just some of your users: 

    message = CloudFivePush::Message.new
    message.message = "Hello from Cloud Five"
    message.user_identifiers = [123, 345, "something@example.com"] # use whatever you registered with on the mobile app
    message.send!

Schedule a notification to be sent in the future: 

    message = CloudFivePush::Message.new
    message.message = "Hello from Cloud Five"
    message.scheduled_at = Time.now + 3600 # 1 hour from now
    message.send!

## Contributing

1. Fork it ( http://github.com/cloudfive/pushapi-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
