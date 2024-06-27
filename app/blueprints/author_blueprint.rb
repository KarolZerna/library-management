# frozen_string_literal: true

class AuthorBlueprint < Blueprinter::Base
  identifier :id

  fields :firstname, :lastname
end
