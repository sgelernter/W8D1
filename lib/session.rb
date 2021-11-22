require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  attr_reader :session_hash 

  def initialize(req)
    @cookie = req.cookies["_rails_lite_app"]
    @session_hash = @cookie ? JSON.parse(@cookie) : {}
  end

  def [](key)
    session_hash[key]
  end

  def []=(key, val)
    session_hash[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    res.set_cookie("_rails_lite_app", path: '/', value: session_hash.to_json)
  end
end
