class Users < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :email
      t.string  :password_digest
      t.boolean :was_email_verified
      t.string  :email_verification_token
    end
  end
end
