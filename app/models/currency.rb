class Currency < ActiveRecord::Base
  validates :prefix, :code, presence: true
end
