# frozen_string_literal: true

module Api
  module V1
    class AuthorsController < ApplicationController
      def index
        @authors = Author.all
        render json: @authors
      end

      def create
        @author = Author.new(author_params)
        if @author.save
          render json: @author, status: :created
        else
          render json: @author.errors, status: :bad_request
        end
      end

      def show
        @author = Author.find(params[:id])
        render json: @author
      end

      private

      def author_params
        params.require(:author).permit(:name)
      end
    end
  end
end
