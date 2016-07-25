class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :url
      t.boolean :read
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
