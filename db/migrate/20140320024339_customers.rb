class Customers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string  :title
      t.string  :first_name
      t.string  :last_name
      t.string  :address1
      t.string  :address2
      t.string  :city
      t.string  :state
      t.string  :zipcode
      t.string  :phone1
      t.string  :phone2
      t.string  :email
      t.string  :cc_type
      t.integer :cc_num1
      t.integer :cc_num2
      t.integer :cc_num3
      t.integer :cc_num4
      t.integer :cc_expiry_month
      t.integer :cc_expiry_year
      t.string  :cardholder_name
    end
  end
end
