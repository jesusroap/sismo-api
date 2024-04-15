class CreateCreateSismoData < ActiveRecord::Migration[7.1]
  def change
    create_table :create_sismo_data do |t|

      t.timestamps
    end
  end
end
