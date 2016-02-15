class CreateUserSets < ActiveRecord::Migration
  def change
    create_table :user_sets do |t|
      t.references :user
      t.references :category
      t.string     :title
      t.text       :description
      t.string     :set_type
      t.boolean    :recommended

      t.timestamps null: false
    end
  end
end