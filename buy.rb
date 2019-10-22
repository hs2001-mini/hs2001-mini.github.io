require './key'
require "net/http"
require "uri"
require "openssl"

key = API_KEY
secret = API_SECRET

timestamp = Time.now.to_i.to_s
method = "POST"
uri = URI.parse("https://api.bitflyer.com")
uri.path = "/v1/me/cancelchildorder"
body = '{
  "product_code": "BTC_JPY",
  "child_order_type": "LIMIT",
  "side": "BUY",
  "price": 850000,
  "size": 0.001,
  "minute_to_expire": 10000,
  "time_in_force": "GTC"
}'

text = timestamp + method + uri.request_uri + body
sign = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), secret, text)

options = Net::HTTP::Post.new(uri.request_uri, initheader = {
  "ACCESS-KEY" => key,
  "ACCESS-TIMESTAMP" => timestamp,
  "ACCESS-SIGN" => sign,
  "Content-Type" => "application/json"
});
options.body = body

https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = true
response = https.request(options)
puts response.body