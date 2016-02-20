class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar, :status, :admins
  has_one :creator
  has_many :members
  root false

  def filter(keys)
    if !serialization_options[:show_users]
      keys - [:creator, :members]
    else
      keys
    end
  end

  def admins
    admins = []
    for group_user in object.group_users
      admins << {"member_id": group_user.id} if group_user.is_admin
    end
    admins
  end

end
