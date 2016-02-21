class Bill < ActiveRecord::Base
  belongs_to :group
  belongs_to :currency
  belongs_to :creator, class_name: "User"
  has_attached_file :receipt,
                    styles: { small: "50x50", med: "140x140", large: "200x200" }

  #Validations
  validates_attachment_content_type :receipt,
          :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :name, :group, :currency, :amount, :creator_id, presence: true

  ##
  # Get authenticated user's bill by ID
  def self.find(id, current_user)
    Bill.includes(group: [:group_users]).where(id: id,
                              group_users: { user_id: current_user.id } ).first
  end

  ##
  # Get all bills from authenticated user
  def self.find_all(current_user)
    Bill.where(creator_id: current_user.id)
  end
end
