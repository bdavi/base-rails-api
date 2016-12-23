class CreateOrganizations < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.text :address
      t.text :phone
      t.string :url
      t.string :email

      t.timestamps
    end
  end
end
