class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      t.integer :name
      t.boolean :is_active

      t.timestamps
    end
  end
end
