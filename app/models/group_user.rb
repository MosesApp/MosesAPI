class GroupUser < ActiveRecord::Base
  #Associations
  belongs_to :user
  belongs_to :group

  #Validation
  validates :user, :group, presence: true

  def ==(group_user)
    group_user != nil &&
        self.user_id == group_user.user_id &&
        self.group_id == group_user.group_id
  end
end
