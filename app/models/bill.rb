class Bill < ActiveRecord::Base
  belongs_to :group
  belongs_to :currency
  has_attached_file :receipt,
                    styles: { small: "50x50", med: "140x140", large: "200x200" }

  #Validations
  validates_attachment_content_type :receipt,
          :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :name, :group, :currency, :amount, presence: true
end
