class Group < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  has_attached_file :image,
                    styles: { small: "50x50", med: "140x140", large: "200x200" }
  validates_attachment_content_type :image,
          :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :name, :creator_id, :status, presence: true

end
