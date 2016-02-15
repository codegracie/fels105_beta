class CreateFelsCoreDatabase < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, index: true
      t.string :last_name, index: true
      t.string :email, unique: true
      t.string :password_digest
      t.string   :avatar
      t.boolean :admin, default: false

      t.timestamps null: false
    end

    create_table :categories do |t|
      t.string   :name, index: true
      t.text     :description
      t.string   :picture

      t.timestamps null: false
    end

    create_table :words do |t|
      t.references :category, index: true
      t.string     :content

      t.timestamps null: false
    end

    create_table :answers do |t|
      t.references :word
      t.string     :content
      t.boolean    :correct

      t.timestamps null: false
    end

    create_table :lessons do |t|
      t.references :user, index: true
      t.references :category, index: true
      t.string     :result

      t.timestamps null: false
    end

    create_table :lesson_words do |t|
      t.references :lesson, index: true
      t.references :word
      t.references :answer
      t.boolean    :correct

      t.timestamps null: false
    end
  end
end
