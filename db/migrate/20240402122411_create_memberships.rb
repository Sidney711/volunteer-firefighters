class CreateMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :memberships do |t|
      t.date :start_date
      t.references :fire_department, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.string :role
      t.string :status

      t.timestamps
    end
  end
end
