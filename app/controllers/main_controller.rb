class MainController < ApplicationController
  
  def index
  end
  
  def contacts
  end

  # Заглушка для несуществующих route. К примеру картинок подгружаемых библиотеками JS
  def missing
    render json: { status: 'nmissing' }, status: :accepted
  end

end
