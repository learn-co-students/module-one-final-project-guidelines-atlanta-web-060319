class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change

    create_table :restaurants do |t|
      t.string :name 
      t.string :neighborhood 
      t.integer :rating 
      t.boolean :salsa_variety?  
    end 


  end
end
