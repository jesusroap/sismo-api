class ChangeNombreColumnNotNull < ActiveRecord::Migration[7.1]
  def change
    change_column :comments, :body, :text, null: false
  end
end
