class FacebookHelper
  def initialize(token)
    @token = token
    @app_id = '526491780867557'
  end

  def valid_token?
    return false if @token == nil
    facebook = URI.parse('https://graph.facebook.com/app?
                                          access_token=' + @token)
    response = Net::HTTP.get_response(facebook)
    app_data = JSON.parse(response.body)
    app_data['id'] == @app_id
  end

  def user_data
    facebook = URI.parse('https://graph.facebook.com/me?
                          fields=first_name,timezone,name,email,locale
                                          &access_token=' + @token)
    response = Net::HTTP.get_response(facebook)
    user = JSON.parse(response.body)
    #Convert to our model
    user['full_name'] = user.delete 'name'
    user['facebook_id'] = user.delete 'id'
    user
  end
end
