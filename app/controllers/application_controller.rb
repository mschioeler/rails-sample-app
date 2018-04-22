class ApplicationController < ActionController::Base
  def hello
    render html: "Hello, world"
  end
  protect_from_forgery with: :exception
end
