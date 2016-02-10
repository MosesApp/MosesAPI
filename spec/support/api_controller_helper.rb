module ApiControllerHelper
  def stub_access_token(token)
    allow_any_instance_of(ApplicationController).to receive(:doorkeeper_token).and_return(token)
  end

  def stub_current_user(user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
end
