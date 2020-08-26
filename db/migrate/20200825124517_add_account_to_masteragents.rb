class AddAccountToMasteragents < ActiveRecord::Migration[5.2]
  def change
    add_column :masteragents, :account, :boolean
  end
end
