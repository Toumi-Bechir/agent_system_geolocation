class CreateAgents < ActiveRecord::Migration[5.2]
  def change
    create_table :agents do |t|
      t.string :name
      t.decimal :lat
      t.decimal :lng
      t.timestamps
      t.references :masteragents, foreign_key: true
    end
  end
end
