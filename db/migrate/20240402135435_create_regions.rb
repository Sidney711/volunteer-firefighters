class CreateRegions < ActiveRecord::Migration[7.1]
  def change
    create_table :regions do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
    add_index :regions, :code, unique: true
  end
end
