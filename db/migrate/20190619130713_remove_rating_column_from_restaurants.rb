class RemoveRatingColumnFromRestaurants < ActiveRecord::Migration[5.0]
  def change
    change_table :restaurants do |t|
      t.remove :rating 
    end
  end
end
