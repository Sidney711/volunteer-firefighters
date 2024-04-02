class CreateFireDepartments < ActiveRecord::Migration[7.1]
  def change
    create_table :fire_departments do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.references :district, null: false, foreign_key: true
      t.string :address, null: false

      t.timestamps
    end
    add_index :fire_departments, :code, unique: true
  end
end
