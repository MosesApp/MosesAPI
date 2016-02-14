class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.attachment :avatar
      t.integer :creator_id, references: :users
      t.string :status

      t.timestamps null: false
    end
  end
end
