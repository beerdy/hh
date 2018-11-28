class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def initialize
    super
    @cart = Cart.new
  end
end
