# frozen_string_literal: true

# == Schema Information
#
# Table name: authors
#
#  id         :bigint           not null, primary key
#  firstname  :string
#  lastname   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Author < ApplicationRecord
  validates :firstname, :lastname, presence: true
end
