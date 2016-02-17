require 'spec_helper'

describe GroupUser do
  before { @group_user = FactoryGirl.create(:group_user) }
  subject { @group_user }

  #Model
  it { should respond_to(:is_admin) }
  it { should respond_to(:user) }
  it { should respond_to(:group) }

  #Validation
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:group) }

end
