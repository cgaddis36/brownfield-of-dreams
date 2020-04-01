# frozen_string_literal: true

class AddGithubtokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_token, :string
  end
end
