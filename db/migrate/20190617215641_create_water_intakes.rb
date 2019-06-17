class CreateWaterIntakes < ActiveRecord::Migration[5.0]
  def change
    create_table :water_intakes do |t|
      t.integer :user_id
      t.integer :goal_id
      t.integer :tracker
    end
  end
end
