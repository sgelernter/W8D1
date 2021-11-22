require 'json'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  attr_reader :rails_cookie 

  def initialize(req)
    @rails_cookie = req.cookies["_rails_lite_app"]

  end

  def [](key)
  end

  def []=(key, val)
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    Rack::Response.set_cookie(rails_cookie)
  end
end
