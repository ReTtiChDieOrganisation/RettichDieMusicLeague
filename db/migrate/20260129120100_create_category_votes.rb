class CreateCategoryVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :category_votes do |t|
      t.references :category_submission, null: false, foreign_key: true
      t.references :voter, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :category_votes, [ :category_submission_id, :voter_id ], if_not_exists: true
    add_index :category_votes, :voter_id, if_not_exists: true
  end
end
