class CreateSubagents < ActiveRecord::Migration[5.2]
  def change
    create_table :subagents do |t|
      t.string :name
      t.decimal :lat
      t.decimal :lng
      t.timestamps
      t.references :agents, foreign_key: true
    end
  end
end
