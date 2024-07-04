# frozen_string_literal: true

namespace :db do
  desc "Remove authors without any books"
  task clean_up_authors: :environment do
    authors_without_books = Author.left_outer_joins(:books).where(books: { id: nil })

    authors_without_books.each do |author|
      puts "Deleting author #{author.firstname} #{author.lastname} (ID: #{author.id})"
      puts "#{authors_without_books.count} author/s without books deleted."
      author.destroy
    end
  end
end