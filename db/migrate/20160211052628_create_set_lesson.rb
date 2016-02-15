class CreateSetLesson < ActiveRecord::Migration
  def change
    create_table :set_lessons do |t|
      t.references :user, index: true
      t.references :user_set, index: true

      t.timestamps null: false
    end
  end
end