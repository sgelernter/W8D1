require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'
require_relative './session'
require 'byebug'

class ControllerBase
  attr_reader :req, :res, :params
  attr_writer :already_built_response

  # Setup the controller
  def initialize(req, res)
    @req = req 
    @res = res
    @already_built_response = false
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise 'double render error' if already_built_response?
    res.status = 302
    res.location = url
    already_built_response = true
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise 'double render error' if already_built_response?
    res.write(content) 
    res.content_type = content_type 
    already_built_response = true 
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    raise 'double render error' if already_built_response?
    debugger
    controller_name = self.class.to_s
    controller_path_name = controller_name.underscore
    full_path = "views/#{controller_path_name}/#{template_name}.html.erb"
    content = File.read(full_path)
    parsed_content = ERB.new(content).result(binding)
    render_content(parsed_content, 'text/html')
  end

  # method exposing a `Session` object
  def session
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
  end
end

