class User < ActiveRecord::Base
  validates :first_name, :full_name, :email,
                        :facebook_id, :locale, :timezone, presence: true
  validates :facebook_id, uniqueness: true, case_sensitive: false
  validates_format_of :email, :with => /@/
  has_attached_file :avatar,
                    styles: { small: "50x50", med: "140x140", large: "200x200" }
  validates_attachment_content_type :avatar,
          :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
end
