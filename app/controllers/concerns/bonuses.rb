module Bonuses
  extend ActiveSupport::Concern

  def get_bonuse
    return unless current_user.card
    card_number current_user.card
    get_info
  end

  def get_info
    @is_user1c_get = false
    
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
      @is_user1c_get = true
    rescue Exception => e
      @data_1C = { "bonusSum" => -1 } # Проблемы с картой
    end
  end

  def is_card_current_user?
    pp @data_1C
    puts "FIO: #{@data_1C["clientName"]}"
    pp current_user
    
    card_number user_params[:card]
    get_info
    return false unless is_user1c_get?

    user_params[:fio].downcase == @data_1C["clientName"].downcase
  end
  def is_user1c_get?
    @is_user1c_get
  end

  private
    def card_number e
      if e.length < 6
        @card = "#{'0'*(6-e.to_s.length)}#{e.to_s}"
      else
        @card = e.to_s
      end
    end
end