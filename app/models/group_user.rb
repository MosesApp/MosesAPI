class GroupUser < ActiveRecord::Base
  #Associations
  belongs_to :user
  belongs_to :group

  #Validation
  validates :user, :group, presence: true
end
