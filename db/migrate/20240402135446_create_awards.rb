class CreateAwards < ActiveRecord::Migration[7.1]
  def change
    create_table :awards do |t|
      t.string :name, null: false
      t.integer :award_type, null: false
      t.integer :dependent_award_id
      t.integer :minimum_service_years, default: 0
      t.integer :minimum_age, default: 0

      t.timestamps
    end
  end
end
