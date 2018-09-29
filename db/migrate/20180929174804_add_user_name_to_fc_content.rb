class AddUserNameToFcContent < ActiveRecord::Migration[5.2]
  def change
    add_column :fc_contents, :username, :string
  end
end
