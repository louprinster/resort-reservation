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
    end
  end
end
