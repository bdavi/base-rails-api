class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.belongs_to :organization, foreign_key: true, null: false

      t.timestamps
    end
  end
end
