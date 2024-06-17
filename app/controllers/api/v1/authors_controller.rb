# frozen_string_literal: true

module Api
  module V1
    class AuthorsController < ApplicationController
      before_action :authenticate_user!, only: [:create]
      before_action :authorize_admin!, only: [:create]

      def index
        @authors = Author.all
        render json: @authors
      end

      def show
        @author = Author.find(params[:id])
        render json: @author
      end

      # rubocop:disable Style/GuardClause
      def create
        @author = Author.new(author_params)
        if @author.save
          render json: @author, status: :created
        else
          raise LibraryErrorHandler::ClientError.new(message: 'Failed to create author', errors: @author.errors.full_messages)
        end
      end
      # rubocop:enable Style/GuardClause

      private

      def author_params
        params.require(:author).permit(:firstname, :lastname)
      end

      def authorize_admin!
        unless current_user&.admin?
          render json: { error: 'Not Authorized' }, status: :unauthorized
        end
      end
    end
  end
end
