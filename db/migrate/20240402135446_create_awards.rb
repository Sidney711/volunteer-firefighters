class CreateAwards < ActiveRecord::Migration[7.1]
  def change
    create_table :awards do |t|
      t.string :name
      t.integer :award_type
      t.string :image
      t.integer :dependent_award_id
      t.integer :minimum_service_years
      t.integer :minimum_age

      t.timestamps
    end
  end
end
