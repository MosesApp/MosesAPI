class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :full_name
      t.string :email
      t.string :facebook_id
      t.string :locale
      t.integer :timezone
      t.string :facebook_token
      t.attachment :avatar

      t.timestamps null: false
    end
  end
end
