class Cart
  attr_accessor :product
  include Mongoid::Document

  field :title, type: String
  field :description, type: String
  field :slave, type: String
  field :image, type: String
  field :link, type: String
  field :tag, type: String
  field :url, type: String
  field :link, type: String
  field :sort, type: Integer
  field :count, type: Integer

  field :product_id, type: String
  field :product_quantify, type: Integer
  field :user_id, type: String

  def product
    @products ||= Array.new
    if @product.nil?
      @product = Product.find self.product_id
    elsif @product.id.to_s == self.product_id
      @product
    else
      @product = Product.find self.product_id
    end
  end
end
