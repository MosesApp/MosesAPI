require 'spec_helper'

describe Group do
  before { @group = FactoryGirl.create(:group, :model) }
  subject { @group }

  #Model
  it { should respond_to(:name) }
  it { should respond_to(:avatar) }
  it { should respond_to(:creator) }
  it { should respond_to(:status) }

  it { should belong_to(:creator) }
  it { should have_many(:members) }

  it { should be_valid }

  #Validation
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:creator_id) }
  it { should validate_presence_of(:status) }

  describe "add members" do
    describe "when has repeated members" do
      before(:each) do
        friend = FactoryGirl.create :user
        @group.add_members([{id: friend.id, is_admin: true},
                                            {id: friend.id, is_admin: false}])
      end

      it "doesn't add repeated members" do
        expect(@group.members.size).to eql 1
      end
    end

    describe "when already has member" do
      before(:each) do
        friend = FactoryGirl.create :user
        @group.add_members([{id: friend.id, is_admin: true}])
        @group.add_members([{id: friend.id, is_admin: false}])
      end

      it "doesn't add repeated members" do
        expect(@group.members.size).to eql 1
      end
    end
  end

end
