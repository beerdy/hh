module ProductsHelper
  def has_image? meta
    File.exist?(URI.decode(Rails.root.to_s + "/public" + get_image(meta).image.url(:thumb, timestamp: false))) if meta
  end
  
  def get_image meta
    Gallery.new JSON.parse meta if meta
  end
  def image_tag_paper_mongoid *options
    # anonced options:
    class_ = ''
    id_ = ''
    width_ = ''
    alt_ = ''
    # END anonced options

    options.each do |opt|
      if opt.is_a?(Hash)
        opt.keys.each { |key|
          puts "current key: #{key}"
          class_ = opt[key] if key.to_s == 'class'
          id_ = opt[key] if key.to_s == 'id'
          width_ = opt[key] if key.to_s == 'width'
        }
      end
    end

    image_tag get_image(options[0]).image.url, skip_pipeline: true, class: class_, id: id_, width: width_, alt: alt_, mongo_id: JSON.parse(options[0])['_id']['$oid']
  end
  
  def rand_price_000
    
    if @freezed_price
      price = @freezed_price
      @freezed_price = nil
      return price
    end
    
    @freezed_price ||= Random.new().rand(20..30)*1000
  end
end
