class Restaurant < ActiveRecord::Base 
    has_many :reviews
    has_many :users, through: :reviews
 
    def reviews
        Review.all.select {|r| r.restaurant_id == self.id}
    end


end 