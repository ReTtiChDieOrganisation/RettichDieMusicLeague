class AllowMultipleCategoryVotes < ActiveRecord::Migration[7.1]
  def change
    remove_index :category_votes, name: "index_category_votes_on_category_submission_id_and_voter_id", if_exists: true
    add_index :category_votes, [ :category_submission_id, :voter_id ], if_not_exists: true
  end
end
