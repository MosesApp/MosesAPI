class CreateGroupUsers < ActiveRecord::Migration
  def change
    create_table :group_users do |t|

      t.timestamps null: false
      t.boolean :is_admin, default: false
      t.belongs_to :user, index: true
      t.belongs_to :group, index: true
    end
  end
end
