# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Authors', type: :request do
  describe 'GET /show' do
    let(:author) { FactoryBot.create :author }

    context 'successful show author' do
      it 'should return an author' do
        get "/api/v1/authors/#{author.id}"
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:ok)
        expect(json['firstname']).to eq(author.firstname)
        expect(json['lastname']).to eq(author.lastname)
      end
    end

    context 'failure show author' do
      it 'the requested author does not exist' do
        get "/api/v1/authors/#{Faker::Alphanumeric.alphanumeric(number: 2)}"

        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /create' do
    let(:valid_payload) { { name: Faker::Name.name } }
    let(:invalid_payload) { { name: '' } }

    context 'successful create author' do
      it 'should create an author' do
        post '/api/v1/authors', params: valid_payload, as: :json
        json = JSON.parse(response.body)

        expect(response).to have_http_status(:created)
        expect(json['firstname']).to eq(valid_payload[:firstname])
      end
    end

    context 'create author error' do
      it 'should not create an author with empty name' do
        post '/api/v1/authors', params: invalid_payload, as: :json

        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
