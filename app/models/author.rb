# frozen_string_literal: true

class Author < ApplicationRecord
  validates :firstname, :lastname, presence: true
end
