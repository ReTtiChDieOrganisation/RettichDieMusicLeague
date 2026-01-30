class MoveCategorySubmissionsToGroups < ActiveRecord::Migration[7.1]
  def up
    add_reference :category_submissions, :group, foreign_key: true

    CategorySubmission.reset_column_information
    CategorySubmission.find_each do |submission|
      season = Season.find(submission.season_id)
      submission.update_columns(group_id: season.group_id)
    end

    change_column_null :category_submissions, :group_id, false
    remove_reference :category_submissions, :season, foreign_key: true
  end

  def down
    add_reference :category_submissions, :season, foreign_key: true
    CategorySubmission.reset_column_information
    CategorySubmission.find_each do |submission|
      submission.update_columns(season_id: submission.group.seasons.first&.id)
    end
    change_column_null :category_submissions, :season_id, false
    remove_reference :category_submissions, :group, foreign_key: true
  end
end
