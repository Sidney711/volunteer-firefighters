class CreateAccountAwards < ActiveRecord::Migration[7.1]
  def change
    create_table :account_awards do |t|
      t.references :account, null: false, foreign_key: true
      t.references :award, null: false, foreign_key: true

      t.timestamps
    end
  end
end
