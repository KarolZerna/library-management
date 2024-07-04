# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id               :bigint           not null, primary key
#  isbn             :string
#  publication_date :datetime
#  status           :enum             default("available"), not null
#  title            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  author_id        :bigint           not null
#
# Indexes
#
#  index_books_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => authors.id)
#
class Book < ApplicationRecord
  belongs_to :author
end
