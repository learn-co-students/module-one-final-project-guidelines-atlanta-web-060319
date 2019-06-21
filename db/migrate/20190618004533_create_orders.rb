class CreateOrders < ActiveRecord::Migration[5.0]
  	def change
  		create_table :orders do |t|
	      	t.belongs_to :user, index: true
	      	t.belongs_to :sandwich, index: true
	      	t.string :bread
	      	t.string :green
	      	t.string :condiment
	      	t.string :recipe
	    end
  	end
end
