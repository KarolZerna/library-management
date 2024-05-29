# frozen_string_literal: true

class RemoveUnnecessaryColumnsFromAuthors < ActiveRecord::Migration[7.1]
  def change
    remove_column :authors, :remember_created_at, :datetime
    remove_column :authors, :reset_password_sent_at, :datetime
    remove_column :authors, :reset_password_token, :string
    remove_column :authors, :encrypted_password, :string
    remove_column :authors, :email, :string
  end
end
