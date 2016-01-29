class User < ActiveRecord::Base
  validates :first_name, :full_name, :email,
                        :facebook_id, :locale, :timezone, presence: true
  validates :facebook_id, uniqueness: true, case_sensitive: false
end
