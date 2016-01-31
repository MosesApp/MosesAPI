require 'spec_helper'

describe Api::V1::UsersController do
  before(:each) { request.headers['Accept'] = "application/application/vnd.mosesapi.v1" }

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id, format: :json
    end

    it "returns the information about a reporter on a hash" do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:email]).to eql @user.email
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, { user: @user_attributes }, format: :json
      end

      it "renders the json representation for the user record just created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eql @user_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context "when is missing attribute" do
      before(:each) do
        @invalid_user_attributes = {email: '', first_name: '', full_name: '',
                                    facebook_id: '', locale: '', timezone: ''}
        post :create, { user: @invalid_user_attributes }, format: :json
      end

      it "renders an errors json" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:email]).to include "can't be blank"
        expect(user_response[:errors][:first_name]).to include "can't be blank"
        expect(user_response[:errors][:full_name]).to include "can't be blank"
        expect(user_response[:errors][:facebook_id]).to include "can't be blank"
        expect(user_response[:errors][:locale]).to include "can't be blank"
        expect(user_response[:errors][:timezone]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end

    context "when has duplicate facebook_id" do
      before(:each) do
        @invalid_user_attributes = FactoryGirl.attributes_for :user
        post :create, { user: @invalid_user_attributes }, format: :json
        post :create, { user: @invalid_user_attributes }, format: :json
      end

      it "renders an errors json" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:facebook_id]).to include "has already been taken"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do

    context "when is successfully updated" do
      before(:each) do
        @user = FactoryGirl.create :user
        @new_user = { email: "new@email.com",
                              first_name: "New", full_name: "New Name",
                              facebook_id: "12011022", locale: 'pt_BR',
                              timezone: 2 }
        patch :update, { id: @user.id, user: @new_user }, format: :json
      end

      it "renders the json representation for the updated user" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eql @new_user[:email]
        expect(user_response[:first_name]).to eql @new_user[:first_name]
        expect(user_response[:full_name]).to eql @new_user[:full_name]
        expect(user_response[:facebook_id]).to eql @new_user[:facebook_id]
        expect(user_response[:locale]).to eql @new_user[:locale]
        expect(user_response[:timezone]).to eql @new_user[:timezone]

      end

      it { should respond_with 200 }
    end

    context "when has invalid email" do
      before(:each) do
        @user = FactoryGirl.create :user
        patch :update, { id: @user.id,
                        user: { email: "email.com"}, format: :json }
      end

      it "renders an errors json" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:errors][:email]).to include "is invalid"
      end

      it { should respond_with 422 }
    end
  end
end
