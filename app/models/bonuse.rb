class Bonuse
  include Mongoid::Document
  field :used_id, type: Integer
  field :fio, type: String
  field :birthday, type: String

  field :bonuses, type: Array, default: []
end
