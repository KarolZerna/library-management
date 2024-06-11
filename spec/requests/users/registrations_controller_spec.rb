# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::RegistrationsController', type: :request do
  include Devise::Test::ControllerHelpers

  describe 'POST #create' do
    context 'when valid sign-up details are provided' do
      let(:user_params) { FactoryBot.create :user, email: 'user@example.com', password: 'password123', password_confirmation: 'password123' }

      it 'returns a successful response with the correct JSON' do
        post '/users', params: { user: user_params }, as: :json

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['status']['code']).to eq(200)
        expect(json_response['status']['message']).to eq('Signed up successfully')
        expect(json_response['status']['data']['email']).to eq(user_params[:email])
      end
    end

    context 'when invalid sign-up details are provided' do
      let(:invalid_user_params) { FactoryBot.create :user, email: 'user@example.com', password: 'admin', password_confirmation: 'admin' }

      it 'returns an error response with the correct JSON' do
        post '/users', params: { user: invalid_user_params }, as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['status']['message']).to eq('User could not be created')
        expect(json_response['status']['errors']).to include("Password is too short (minimum is 6 characters)")
      end
    end
  end
end
