class AddStructIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :struct_id, :integer
  end
end