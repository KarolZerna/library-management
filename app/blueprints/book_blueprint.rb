# frozen_string_literal: true

class BookBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :isbn, :publication_date, :status

  view :normal do
    fields :title, :isbn, :publication_date, :status
  end

  association :author, blueprint: AuthorBlueprint
end
