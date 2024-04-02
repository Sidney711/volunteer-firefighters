class CreateDistricts < ActiveRecord::Migration[7.1]
  def change
    create_table :districts do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.references :region, null: false, foreign_key: true

      t.timestamps
    end
    add_index :districts, :code, unique: true
  end
end
