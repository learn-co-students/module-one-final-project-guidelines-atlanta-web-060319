class Goal < ActiveRecord::Base
  has_many :water_intakes
  has_many :users, through: :water_intakes
end
