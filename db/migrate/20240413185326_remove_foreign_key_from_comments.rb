class RemoveForeignKeyFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_reference :comments, :user, foreign_key: true
  end
end
