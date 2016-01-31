require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  #Model
  it { should respond_to(:first_name) }
  it { should respond_to(:full_name) }
  it { should respond_to(:email) }
  it { should respond_to(:facebook_id) }
  it { should respond_to(:locale) }
  it { should respond_to(:timezone) }

  it { should be_valid }

  #Validation
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:facebook_id) }
  it { should validate_uniqueness_of(:facebook_id).case_insensitive }
  it { should allow_value("example@email.com").for(:email) }
  it { should_not allow_value("email.com").for(:email) }
end