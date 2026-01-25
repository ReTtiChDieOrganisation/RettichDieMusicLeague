class CreateTidalAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :tidal_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :access_token, null: false
      t.string :refresh_token
      t.datetime :expires_at

      t.timestamps
    end
  end
end
