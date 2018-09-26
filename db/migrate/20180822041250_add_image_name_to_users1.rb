class AddImageNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image_name, :string, default: "default_image.jpg"
  end
end
