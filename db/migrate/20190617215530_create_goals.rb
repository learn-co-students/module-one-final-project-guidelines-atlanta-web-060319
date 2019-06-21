class CreateGoals < ActiveRecord::Migration[5.0]
  def change
    create_table :goals do |t|
      t.integer :cup
      t.boolean :goal_met
    end
  end
end
