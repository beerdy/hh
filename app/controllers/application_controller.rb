class ApplicationController < ActionController::Base
  include AuthFake
  
  protect_from_forgery with: :exception
end


