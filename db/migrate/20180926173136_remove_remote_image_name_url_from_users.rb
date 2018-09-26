class RemoveRemoteImageNameUrlFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :remote_image_nameurl, :string
  end
end
