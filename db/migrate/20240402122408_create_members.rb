class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.string :full_name
      t.date :birth_date
      t.string :permanent_address
      t.string :email
      t.string :phone
      t.string :member_code
      t.string :role

      t.timestamps
    end
  end
end
