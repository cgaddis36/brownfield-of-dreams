# frozen_string_literal: true

class AddUrlToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :url, :string
  end
end
