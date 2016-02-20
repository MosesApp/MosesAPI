class User < ActiveRecord::Base
  #Associations
  has_many :group_users
  has_many :groups, through: :group_users
  has_attached_file :avatar,
                    styles: { small: "50x50", med: "140x140", large: "200x200" }

  #Validations
  validates :first_name, :full_name,
                        :facebook_id, :locale, :timezone, presence: true
  validates :facebook_id, uniqueness: true, case_sensitive: false
  validates_format_of :email, :with => /@/, allow_blank: true
  validates_attachment_content_type :avatar,
          :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
