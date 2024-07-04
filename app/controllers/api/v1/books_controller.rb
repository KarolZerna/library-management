# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApplicationController
      include Pagy::Backend

      before_action :authenticate_user!, only: [:create]
      before_action :authorize_admin!, only: [:create]

      def index
        author = Author.includes(:books).find(params[:author_id])
        render json: BookBlueprint.render(author.books, view: :normal)
      end

      def show
        book = Book.find(params[:id])
        render json: BookBlueprint.render(book, view: :normal)
      end

      # rubocop:disable Style/GuardClause
      def create
        @book = Book.new(book_params)
        if @book.save
          render json: @book, status: :created
        else
          raise LibraryErrorHandler::ClientError.new(message: 'Failed to create book', errors: @book.errors.full_messages)
        end
      end
      # rubocop:enable Style/GuardClause

      private

      def book_params
        params.require(:book).permit(:title, :isbn, :publication_date, :status, :author_id)
      end

      # rubocop:disable Style/GuardClause, Style/IfUnlessModifier
      def authorize_admin!
        unless current_user&.admin?
          render json: { error: 'Not Authorized' }, status: :unauthorized
        end
      end
      # rubocop:enable Style/GuardClause, Style/IfUnlessModifier
    end
  end
end
