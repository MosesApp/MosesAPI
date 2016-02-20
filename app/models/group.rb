class Group < ActiveRecord::Base
  #Associations
  belongs_to :creator, class_name: "User"
  has_many :group_users
  has_many :members, through: :group_users, source: :user
  has_attached_file :avatar,
                    styles: { small: "50x50", med: "140x140", large: "200x200" }

  #Validations
  validates_attachment_content_type :avatar,
          :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :name, :creator_id, :status, presence: true
  validates_attachment_content_type :avatar,
          :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  ##
  # Finds group by ID, restricting results to groups
  # that the current_user is part of.
  def find(id)
    Group.includes([:members, :group_users]).where(id: id,
                                    group_users: { user: current_user } ).first
  end

  ##
  # Add members to group
  def add_members(members)    
    members.each do | member |
      GroupUser.create!(group_id: self.id, user_id: member[:id],
                                            is_admin: member[:is_admin])
    end
  end

end
