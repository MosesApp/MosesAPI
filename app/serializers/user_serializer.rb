class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :full_name, :email,
                          :facebook_id, :locale, :timezone
  root false
end
