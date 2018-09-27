class RemoveContentTitleFromFcContent < ActiveRecord::Migration[5.2]
  def change
    remove_column :fc_contents, :content_title, :text
  end
end
