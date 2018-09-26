class AddRemoteImageNameUrlToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :remote_image_name_url, :string
  end
end
