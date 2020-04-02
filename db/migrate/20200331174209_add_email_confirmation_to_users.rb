# frozen_string_literal: true

class AddEmailConfirmationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email_confirm, :boolean, default: false
  end
end
