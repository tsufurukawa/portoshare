class CreateAuthorization < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :provider, :uid, :access_token
      t.integer :user_id
      t.timestamps
    end
  end
end
