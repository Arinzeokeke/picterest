class AddColumnToUsers2 < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :bio, :text
  end
end
