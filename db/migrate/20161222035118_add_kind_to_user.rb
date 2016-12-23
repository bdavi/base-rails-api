class AddKindToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :kind, :integer, null: false, default: 1
  end
end
