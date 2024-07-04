# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_enum :status, %w[available borrowed under_maintenance]

    create_table :books do |t|
      t.string :title
      t.string :isbn
      t.datetime :publication_date
      t.enum :status, enum_type: 'status', default: 'available', null: false
      t.references :author, foreign_key: true, null: false
      t.timestamps
    end
  end
end
