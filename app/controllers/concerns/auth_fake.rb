module AuthFake
  extend ActiveSupport::Concern
  
  def check_auth
    unless current_user.respond_to? :admin?
      @current_user = AuthFake.new 
      method_name = 'user_signed_in?'
      self.class.send(:define_method, method_name ) do
        false
      end
    end
  end

  class AuthFake
    def admin?
      false
    end
    def fake
      true
    end
  end
end