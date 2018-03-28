require 'rails_helper'

RSpec.describe V1::UsersController, type: :request do
  let(:params) do
    {
      name:                  'Hristo Georgiev',
      email:                 'hristo@gmail.com',
      password:              password,
      # password_confirmation: password
    }
  end

  let(:password) { SecureRandom.base64(8) }

  describe 'GET #index' do
    it 'returns a success response' do
      user = User.create! params
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      user = User.create! params
      get user_path user
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      xit 'creates a new User' do
        expect {
          post users_path, params: params
        }.to change(User, :count).by(1)
      end

      xit 'renders a JSON response with the new user' do
        post users_path, params: params
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(user_url(User.last))
      end
    end

    context 'with invalid params' do
      context 'without email' do
        let(:params) do
          {
            name:                  'Hristo Georgiev',
            email:                 '',
            password:              password,
            password_confirmation: password
          }
        end

        xit 'renders a JSON response with errors for the new user' do
          post users_path, params: params
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'without password' do
        let(:params) do
          {
            name:                  'Hristo Georgiev',
            email:                 'hristo@gmail.com',
            password:              '',
            password_confirmation: password
          }
        end

        xit 'renders a JSON response with errors for the new user' do
          post users_path, params: params
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json')
        end
      end

      context 'without password confirmation' do
        let(:params) do
          {
            name:                  'Hristo Georgiev',
            email:                 'hristo@gmail.com',
            password:              password,
            password_confirmation: ''
          }
        end

        xit 'renders a JSON response with errors for the new user' do
          post users_path, params: params
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq('application/json')
        end
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      xit "updates the requested user" do
        user = User.create! valid_attributes
        put :update, params: {id: user.to_param, user: new_attributes}
        user.reload
        skip("Add assertions for updated state")
      end

      xit "renders a JSON response with the user" do
        user = User.create! valid_attributes

        put :update, params: {id: user.to_param, user: valid_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      xit "renders a JSON response with errors for the user" do
        user = User.create! valid_attributes

        put :update, params: {id: user.to_param, user: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    xit "destroys the requested user" do
      user = User.create! valid_attributes
      expect {
        delete :destroy, params: {id: user.to_param}
      }.to change(User, :count).by(-1)
    end
  end

end
require 'rails_helper'
