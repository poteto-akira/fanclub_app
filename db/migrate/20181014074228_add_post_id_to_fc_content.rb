class AddPostIdToFcContent < ActiveRecord::Migration[5.2]
  def change
    add_column :fc_contents, :post_id, :integer
  end
end
