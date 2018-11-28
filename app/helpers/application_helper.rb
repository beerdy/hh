module ApplicationHelper

  def current_cart
    @current_cart ||= CartTools.new(current_user) if user_signed_in?
  end

  class CartTools
    attr_reader :cart
    attr_reader :count

    def initialize current_user
      cart_ current_user
      count_
    end

    def count_
      @count = 0
      @cart.each do |item|
        @count += item.product_quantify
      end
    end

    def cart_ current_user
      @cart = Cart.where(user_id: current_user.id)
    end
  end
end
