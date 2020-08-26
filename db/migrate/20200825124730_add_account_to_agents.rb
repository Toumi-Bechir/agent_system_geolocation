class AddAccountToAgents < ActiveRecord::Migration[5.2]
  def change
    add_column :agents, :account, :boolean
  end
end
