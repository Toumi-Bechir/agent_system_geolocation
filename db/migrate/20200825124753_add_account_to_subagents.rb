class AddAccountToSubagents < ActiveRecord::Migration[5.2]
  def change
    add_column :subagents, :account, :boolean
  end
end
