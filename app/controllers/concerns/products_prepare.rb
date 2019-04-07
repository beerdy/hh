module ProductsPrepare
  extend ActiveSupport::Concern

  def products_prepare_for_order
    products = Array.new
    0.upto(10) { |count|

      position = "product#{count}"
      if params[position]
        products << params[position]
      else
        break
      end
    }
    return products
  end
end

#.push ({ value: l.to_slug_param, label: l.upcase })