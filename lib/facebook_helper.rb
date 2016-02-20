class FacebookHelper
  def initialize(token)
    @token = token
    @app_id = '526491780867557'
  end

  def valid_token?
    return false if @token == nil
    facebook = URI.parse("https://graph.facebook.com/app?" +
                            "access_token=#{@token}")
    response = Net::HTTP.get_response(facebook)

    Rails.logger.debug response.body.inspect

    app_data = JSON.parse(response.body)
    app_data['id'] == @app_id
  end

  def user_data
    facebook = URI.parse("https://graph.facebook.com/me?" +
                            "fields=first_name,timezone,name,email,locale" +
                            "&access_token=#{@token}")
    response = Net::HTTP.get_response(facebook)

    Rails.logger.debug response.body.inspect

    user = JSON.parse(response.body)
    #Convert to our model
    user['full_name'] = user.delete 'name'
    user['facebook_id'] = user.delete 'id'
    user['facebook_token'] = long_term_token
    user
  end

  def long_term_token
    facebook = URI.parse("https://graph.facebook.com/v2.5/oauth/access_token?" +
                            "grant_type=fb_exchange_token" +
                            "&client_id=#{Rails.configuration.fb_app_id}" +
                            "&client_secret=#{Rails.configuration.fb_app_secret}" +
                            "&fb_exchange_token=#{@token}")

    response = Net::HTTP.get_response(facebook)

    Rails.logger.debug response.body.inspect

    token = JSON.parse(response.body)
    if token['access_token'].present?
      token['access_token']
    else
      @token
    end
  end
end
