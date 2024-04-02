class CreateFireDepartments < ActiveRecord::Migration[7.1]
  def change
    create_table :fire_departments do |t|
      t.string :name
      t.string :code
      t.references :district, null: false, foreign_key: true
      t.string :address

      t.timestamps
    end
  end
end
