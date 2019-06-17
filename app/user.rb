class User < ActiveRecord::Base
  has_many :water_intakes
  has_many :goals, through: :water_intakes
end
