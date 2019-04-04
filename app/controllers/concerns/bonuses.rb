module Bonuses
  extend ActiveSupport::Concern

  def get_bonuse
    return unless current_user.card

    @card = "000#{current_user.card}"
    
    @toSend = {
      "cardId"=>@card
    }.to_json

    uri = URI.parse("http://79.111.122.45:88/front_bonuses/hs/bonuses/getSum")
    http = Net::HTTP.new(uri.host,uri.port)
    
    #https.use_ssl = true
    
    req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    req.basic_auth 'otklik1c', '123456'
    
    #req['foo'] = 'bar'
    
    req.body = "#{@toSend}"
    res = http.request(req)
    res_tmp = "Response #{res.code} #{res.message}: #{res.body}"
  
    begin
      @data_1C = JSON.parse(res.body.force_encoding("UTF-8"))
      @data_1C["bonusSum"] = @data_1C["bonusSum"].to_i
    rescue Exception => e
      @data_1C = { "bonusSum" => -1 } # Проблемы с картой
    end
  end
end