class CreateSandwiches < ActiveRecord::Migration[5.0]
  	def change
  		create_table :sandwiches do |t|
	      	t.string :meat
	      	t.string :cheese
	      	t.string :name
	    end
 	end
end
