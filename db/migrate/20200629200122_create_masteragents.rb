class CreateMasteragents < ActiveRecord::Migration[5.2]
  def change
    create_table :masteragents do |t|
      t.string :name
      t.decimal :lat
      t.decimal :lng
      t.timestamps
    end
  end
end
