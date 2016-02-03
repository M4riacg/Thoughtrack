class CreatePriorities < ActiveRecord::Migration
  def change
    create_table :priorities do |t|
      t.string :name
      t.integer :level
      t.string :color

      t.timestamps null: false
    end
  end
end
