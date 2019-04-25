class InitializeCard
  attr_accessor :data

  attr_reader :card_id
  attr_reader :card_type
  attr_reader :bonus_sum
  attr_reader :percent_sum

  def type
    @card_type ||= get_type
  end
  def error
    { 
      "bonusSum"   => -1, 
      "percentSum" => -1,
    }
  end

  private
    def get_type
      # Тестовая заглушка
      # @data["cardId"] = "560,20%"

      data_fields = @data["cardId"].to_s.split(',')

      case data_fields.count
      when 1
        @bonus_sum = @data["bonusSum"]

        return 'bonuses'
      when 2
        # Берем номер карты
        @card_id = data_fields[0]
        # Берем проценты
        @percent_sum = data_fields[1]
        
        return 'percent'
      else
        # По умолчанию карта не распознана
        return 'unknown'
      end
    end
end

module Bonuses
  extend ActiveSupport::Concern

  def get_bonuse
    return unless current_user.card
    card_number(current_user.card)
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
    #res_tmp = "Response #{res.code} #{res.message}: #{res.body}"
    
    card = InitializeCard.new
    begin
      @data_1C = JSON.parse(res.body.force_encoding("UTF-8"))

      card.data = @data_1C
      
      case card.type
      when 'bonuses'
        @data_1C["bonusSum"]   = card.bonus_sum
      when 'percent'
        @data_1C["cardId"]     = card.card_id
        @data_1C["percentSum"] = card.percent_sum
      else
        @data_1C = card.error
      end
      @data_1C["cardType"] = card.type

      @is_user1c_get = true
      
      # pp "ПРОПАРСЕННО:"
      # pp @data_1C
    rescue Exception => e
      @data_1C = ({ exception: e }).merge(card.error) # Проблемы с картой
    end
  end

  # POST 
  def move_bonuses
    card_src = card_number(current_user.card)
    card_dst = card_number(params[:card])

    if card_src == card_dst
      render json: { status: 'youcard' }, status: :accepted
    elsif @data_1C["bonusSum"] < params[:count].to_i
      render json: { status: 'notenough' }, status: :accepted
    else
      @toSend = {
        "cardIdFrom" => card_src,
        "cardIdTo"   => card_dst,
        "sum"        => params[:count].to_i
      }.to_json

      uri = URI.parse("http://79.111.122.45:88/front_bonuses/hs/bonuses/moveSum")
      http = Net::HTTP.new(uri.host,uri.port)
      #https.use_ssl = true
      req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
      req.basic_auth 'otklik1c', '123456'
      #req['foo'] = 'bar'
      req.body = @toSend.to_s
      res = http.request(req)
      #{}"Response #{res.code} #{res.message}: #{res.body}"
      if res.code.to_i == 200
        status = 'ok'
      else
        status = 'errorservice'
      end
      render json: { status: status }, status: :accepted
    end
  end

  def is_card_current_user?
    #pp @data_1C
    #puts "FIO: #{@data_1C["clientName"]}"
    #pp current_user
    
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

    def init_card_data
      @data_1C["bonusSum"]
      case card_type
       when 'bonuses'
         
       end 
        @data_1C["bonusSum"] = @data_1C["bonusSum"].to_i
      else
        @data_1C["percentSum"] = get_percent_from_bonus_filed @data_1C["bonusSum"]
    end
end