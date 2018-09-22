class CreateFcContents < ActiveRecord::Migration[5.2]
  def change
    create_table :fc_contents do |t|
      t.text :content_title
      t.text :content_body
      t.integer :user_id
      t.integer :fc_id
      t.string :content_image

      t.timestamps
    end
  end
end
