require 'rack'
require 'byebug'

app = Proc.new do |env|
    req = Rack::Request.new(env)
    path_string = req.path
    res = Rack::Response.new 
    res['Content-Type'] = 'text/html'
    res.write(path_string)
    res.finish 
end

Rack::Server.start(
    app: app,
    Port: 3000
)