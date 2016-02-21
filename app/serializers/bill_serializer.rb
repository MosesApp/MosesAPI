class BillSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :amount, :created_at
  has_one :currency
  has_one :group
  root false
  
  def filter(keys)
    if serialization_options[:hide_details]
      keys - [:group, :description]
    else
      keys
    end

  end
end
