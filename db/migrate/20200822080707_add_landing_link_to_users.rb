class AddLandingLinkToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :landing_link, :string
  end
end
