class CreateUserPasswordResetRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :user_password_reset_requests do |t|
      t.string :email, null: false

      t.timestamps
    end
  end
end
