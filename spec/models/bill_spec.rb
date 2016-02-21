require 'spec_helper'

describe Bill do
  before { @bill = FactoryGirl.build(:bill, :model) }
  subject { @bill }

  #Model
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:receipt) }
  it { should respond_to(:amount) }

  it { should belong_to(:group) }
  it { should belong_to(:currency) }
  it { should belong_to(:creator) }

  it { should be_valid }

  #Validation
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:group) }
  it { should validate_presence_of(:currency) }
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:creator_id) }

end
