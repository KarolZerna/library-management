# frozen_string_literal: true

class AuthorBlueprint < Blueprinter::Base
  identifier :id

  fields :firstname, :lastname

  view :normal do
    fields :firstname, :lastname
  end
end
