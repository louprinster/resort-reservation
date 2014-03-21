class USStates < ActiveRecord::Migration
  def change
    create_table :u_s_states do |t|
      t.string :abbreviation
      t.string :name
    end
  end
end
