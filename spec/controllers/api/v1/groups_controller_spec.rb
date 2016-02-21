require 'spec_helper'

describe Api::V1::GroupsController do
  let(:user) { FactoryGirl.create(:user_with_groups, :controller) }
  let(:token) { double acceptable?: true }

  describe "GET #index" do
    context "when successfully authenticated" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        get :index
      end

      it "returns the user's groups" do
        group_response = json_response
        expect(group_response[:groups].size).to eql user.groups.size
      end

      it "returns the group information" do
        group_response = json_response

        group_response[:groups].each_with_index do |group, index|
          expect(group[:name]).to eql user.groups[index].name
          expect(group[:status]).to eql user.groups[index].status
        end
      end

      it { should respond_with 200 }
    end

    context "when user not authenticated" do
      before(:each) do
        get :index
      end

      it { should respond_with 401 }
    end
  end

  describe "GET #show" do
    context "when successfully gets a group" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        get :show, id: user.groups[1].id
      end

      it "returns the group information" do
        group_response = json_response
        expect(group_response[:name]).to eql user.groups[1].name
        expect(group_response[:creator][:id]).to eql user.groups[1].creator[:id]
        expect(group_response[:status]).to eql user.groups[1].status

      end

      it { should respond_with 200 }
    end

    context "when group does not exist" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        get :show, id: 12345
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the group could not be shown" do
        user_response = json_response
        expect(user_response[:errors]).to include "group not found"
      end

      it { should respond_with 422 }
    end

    context "when user not authenticated" do
      before(:each) do
        get :show, id: 1
      end

      it { should respond_with 401 }
    end
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        @group_attributes = FactoryGirl.attributes_for :group, :controller
        post :create, { group: @group_attributes }
      end

      it "renders the json representation for the group record just created" do
        group_response = json_response
        expect(group_response[:name]).to eql @group_attributes[:name]
        expect(group_response[:status]).to eql @group_attributes[:status]
        expect(group_response[:creator][:id]).to eql user.id
      end

      it { should respond_with 201 }
    end

    context "when is successfully created with group members" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        @group_attributes = FactoryGirl.attributes_for :group, :controller do | group |
          #Add group members
          friend = FactoryGirl.create :user
          group[:members] = [{id: user.id, is_admin: true},
                                              {id: friend.id, is_admin: false}]
        end
        post :create, { group: @group_attributes }
      end

      it "renders the json representation for the group with members" do
        group_response = json_response
        expect(group_response[:name]).to eql @group_attributes[:name]
        expect(group_response[:status]).to eql @group_attributes[:status]
        expect(group_response[:creator][:id]).to eql user.id
        expect(group_response[:members].size).to eql 2
        expect(group_response[:admins].size).to eql 1
        expect(group_response[:admins][0][:member_id]).to eql user.id
      end

      it { should respond_with 201 }
    end

    context "when is has invalid group member" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        @group_attributes = FactoryGirl.attributes_for :group, :controller
        #Add group members
        @group_attributes[:members] = [{id: user.id, is_admin: true},
                                              {id: 12345, is_admin: false}]
        post :create, { group: @group_attributes }
      end

      it "renders an errors json" do
        group_response = json_response
        expect(group_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end


    context "when is missing attribute" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        @invalid_group_attributes = {name: '', status: ''}
        post :create, { group: @invalid_group_attributes }
      end

      it "renders an errors json" do
        group_response = json_response
        expect(group_response).to have_key(:errors)
      end

      it "renders the json errors on why the group could not be created" do
        group_response = json_response
        expect(group_response[:errors][:name]).to include "can't be blank"
        expect(group_response[:errors][:status]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end

    context "when user not authenticated" do
      before(:each) do
        post :create
      end

      it { should respond_with 401 }
    end
  end

  describe "PUT/PATCH #update" do

    context "when is successfully updated group info" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        @update_group = { name: "Updated name", status: "New Status" }
        patch :update, { id: user.groups[0].id, group: @update_group }
      end

      it "renders the json representation for the updated user" do
        group_response = json_response
        expect(group_response[:name]).to eql @update_group[:name]
        expect(group_response[:status]).to eql @update_group[:status]
      end

      it { should respond_with 200 }
    end

    context "when group does not exist" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        patch :update, id: 12345
      end

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the group could not be shown" do
        user_response = json_response
        expect(user_response[:errors]).to include "group not found"
      end

      it { should respond_with 422 }
    end

    context "when user not authenticated" do
      before(:each) do
        patch :update, id: 1
      end

      it { should respond_with 401 }
    end

  end

  describe "DELETE #destroy" do
    context "when group exists and user is admin" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        #Make sure user is admin
        group_user = user.groups[1].group_users[0]
        group_user.is_admin = true
        group_user.save

        delete :destroy, id: user.groups[1].id
      end

      it { should respond_with 204 }
    end

    context "when group exists but user is not admin" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        #Make sure user isn't admin
        group_user = user.groups[1].group_users[0]
        group_user.is_admin = false
        group_user.save

        delete :destroy, id: user.groups[1].id
      end

      it "renders an errors json" do
        group_response = json_response
        expect(group_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end

    context "when group doesn't exist" do
      before(:each) do
        stub_access_token(token)
        stub_current_user(user)
        delete :destroy, id: 123245
      end

      it "renders an errors json" do
        group_response = json_response
        expect(group_response).to have_key(:errors)
      end

      it { should respond_with 422 }
    end

    context "when user not authenticated" do
      before(:each) do
        delete :destroy, id: user.groups[1].id
      end

      it { should respond_with 401 }
    end

  end
end
