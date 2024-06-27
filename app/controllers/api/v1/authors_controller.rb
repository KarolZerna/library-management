# frozen_string_literal: true

module Api
  module V1
    class AuthorsController < ApplicationController
      include Pagy::Backend

      before_action :authenticate_user!, only: [:create]
      before_action :authorize_admin!, only: [:create]
      load_and_authorize_resource

      def index
        @pagy, @authors = pagy(Author.all, items: page_size, page: page_number)
        render json: AuthorBlueprint.render(@authors, root: :data, meta: pagination_metadata)
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

      # rubocop:disable Style/GuardClause
      # rubocop:disable Style/IfUnlessModifier
      def authorize_admin!
        unless current_user&.admin?
          render json: { error: 'Not Authorized' }, status: :unauthorized
        end
      end
      # rubocop:enable Style/IfUnlessModifier
      # rubocop:enable Style/GuardClause
    end
  end
end
