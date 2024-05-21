# frozen_string_literal: true

class AddFirstNameLastNameToAuthors < ActiveRecord::Migration[7.1]
  def change
    change_table :authors do |t|
      t.rename :name, :firstname
      t.string :lastname
    end
  end
end
