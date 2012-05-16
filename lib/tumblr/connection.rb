require 'faraday'
require 'faraday_stack'
require 'tumblr/request/oauth'

module Tumblr
  module Connection
    def connection(options={})
      default_options = {
        :headers => {
          :accept => "application/json",
          :user_agent => "Tumblr v1.0"
        },
        :url => "http://api.tumblr.com/"
      }
      Faraday.new("http://api.tumblr.com/", default_options.merge(options)) do |builder|
        builder.use FaradayStack::ResponseJSON, content_type: "application/json"
        builder.use Tumblr::Request::TumblrOAuth, credentials if not credentials.empty?
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Adapter::NetHttp
      end
    end
  end
end
