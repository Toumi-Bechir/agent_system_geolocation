class CreateShops < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.string :name
      t.decimal :lat
      t.decimal :lng
      t.timestamps
      t.references :subagent, foreign_key: true
    end
  end
end
