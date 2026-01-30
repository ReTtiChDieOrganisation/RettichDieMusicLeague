class AddCategoryPhaseDeadlinesToSeasons < ActiveRecord::Migration[7.1]
  def up
    add_column :seasons, :category_submission_deadline, :datetime
    add_column :seasons, :category_voting_deadline, :datetime

    Season.reset_column_information
    Season.find_each do |season|
      next if season.category_submission_deadline.present? || season.category_voting_deadline.present?

      submission_deadline = (season.start_date + 1.day).end_of_day
      voting_deadline = (season.start_date + 2.days).end_of_day
      season.update_columns(
        category_submission_deadline: submission_deadline,
        category_voting_deadline: voting_deadline
      )
    end
  end

  def down
    remove_column :seasons, :category_submission_deadline
    remove_column :seasons, :category_voting_deadline
  end
end
