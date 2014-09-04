class AddNicknameAndUrlToAuthorization < ActiveRecord::Migration
  def change
    add_column :authorizations, :nickname, :string
    add_column :authorizations, :url, :string
  end
end
