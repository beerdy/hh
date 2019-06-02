class Bonuse
  include Mongoid::Document
  field :used_id, type: Integer
  field :card_id_to, type: Integer
  field :sum, type: Integer
  field :fio, type: String
  field :birthday, type: String

  field :bonuses, type: Array, default: []

  belongs_to :user
end
