require 'spec_helper'

describe Currency do
  before { @currency = FactoryGirl.create(:currency) }
  subject { @currency }

  #Model
  it { should respond_to(:prefix) }
  it { should respond_to(:code) }
  it { should respond_to(:description) }

  it { should be_valid }

  #Validation
  it { should validate_presence_of(:prefix) }
  it { should validate_presence_of(:code) }

end
