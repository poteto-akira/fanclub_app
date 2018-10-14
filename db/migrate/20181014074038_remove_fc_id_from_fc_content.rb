class RemoveFcIdFromFcContent < ActiveRecord::Migration[5.2]
  def change
    remove_column :fc_contents, :fc_id, :integer
  end
end
