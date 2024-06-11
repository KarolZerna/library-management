# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe 'SessionsController', type: :request do
#   include Devise::Test::ControllerHelpers

#   describe 'POST #create' do
#     let(:user) { create(:user) }

#     context 'when valid sign-in credentials are provided' do
#       it 'returns a successful response with the correct JSON' do
#         post '/users/sign_in', params: { user: { email: user.email, password: user.password } }, as: :json

#         expect(response).to have_http_status(:ok)
#         json_response = JSON.parse(response.body)
#         expect(json_response['status']['code']).to eq(200)
#         expect(json_response['status']['message']).to eq('User signed in successfully')
#         expect(json_response['status']['data']['email']).to eq(user.email)
#       end
#     end
#   end

#   describe 'Signed out' do
#     let(:user) { create(:user) }
#     let(:token) { Warden::JWTAuth::UserEncoder.new.call(user, :user, nil).first }

#     context 'when user is signed out successfully' do
#       it 'returns a successful sign-out response' do
#         request.headers['Authorization'] = "Bearer #{token}"
#         delete '/users/sign_out', as: :json

#         expect(response).to have_http_status(:ok)
#         json_response = JSON.parse(response.body)
#         expect(json_response['status']).to eq(200)
#         expect(json_response['message']).to eq('Signed out successfully')
#       end
#     end

#     context 'when user has no active session' do
#       it 'returns an unauthorized response' do
#         delete '/users/sign_out', as: :json

#         expect(response).to have_http_status(:unauthorized)
#         json_response = JSON.parse(response.body)
#         expect(json_response['status']).to eq(401)
#         expect(json_response['message']).to eq('User has no active session')
#       end
#     end
#   end
# end
