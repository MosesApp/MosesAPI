require 'spec_helper'

describe Group do
  before { @group = FactoryGirl.build(:group) }
  subject { @group }

  #Model
  it { should respond_to(:name) }
  it { should respond_to(:image) }
  it { should respond_to(:creator) }
  it { should respond_to(:status) }

  it { should be_valid }

  #Validation
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:creator) }
  it { should validate_presence_of(:status) }

end
