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

  describe "remove members" do
    describe "when removes a non admin member" do
      before(:each) do
        friend = FactoryGirl.create :user
        @user = FactoryGirl.create :user
        @group.add_members([{id: @user.id, is_admin: true},
                                            {id: friend.id, is_admin: false}])
        @group.remove_members([{id: friend.id}])
      end

      it "removes the member" do
        expect(@group.members.size).to eql 1
        expect(@group.members[0].id).to eql @user.id
      end
    end

    describe "when removes an admin member" do
      before(:each) do
        friend = FactoryGirl.create :user
        user = FactoryGirl.create :user
        @group.add_members([{id: user.id, is_admin: true},
                                            {id: friend.id, is_admin: false}])
        @group.remove_members([{id: user.id}])
      end

      it "doesn't remove the member" do
        expect(@group.members.size).to eql 2
      end
    end

    describe "when removes a non existing member" do
      before(:each) do
        friend = FactoryGirl.create :user
        user = FactoryGirl.create :user
        @group.add_members([{id: user.id, is_admin: true},
                                            {id: friend.id, is_admin: false}])
        @group.remove_members([{id: 12345}])
      end

      it "does nothing" do
        expect(@group.members.size).to eql 2
      end
    end
  end

end
