class CreateCategorySubmissions < ActiveRecord::Migration[7.1]
  def change
    create_table :category_submissions do |t|
      t.references :season, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :subtitle, null: false

      t.timestamps
    end

    add_index :category_submissions, [ :season_id, :user_id ]
  end
end
