# frozen_string_literal: true

module Api
  module V1
    class AuthorsController < ApplicationController
      def index
        @authors = Author.all
        render json: @authors
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

      def show
        @author = Author.find(params[:id])
        render json: @author
      end

      private

      def author_params
        params.require(:author).permit(:firstname, :lastname)
      end
    end
  end
end
