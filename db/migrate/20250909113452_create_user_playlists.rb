class CreateUserPlaylists < ActiveRecord::Migration[7.1]
  def change
    create_table :user_playlists do |t|
      t.references :user, null: false, foreign_key: true
      t.references :week, foreign_key: true
      t.string :name, null: false
      t.string :tidal_url, null: false

      t.timestamps
    end

    add_index :user_playlists, [ :user_id, :name ], unique: true
  end
end
