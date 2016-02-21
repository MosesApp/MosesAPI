class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :name
      t.string :description
      t.attachment :receipt
      t.belongs_to :group, index: true
      t.belongs_to :currency, index: true
      t.integer :creator_id, references: :users
      t.float :amount

      t.timestamps null: false
    end
  end
end
