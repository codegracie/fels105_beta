class AddUserSetsToWords < ActiveRecord::Migration
  def change
    add_column :words, :user_set_id, :integer
  end
end
