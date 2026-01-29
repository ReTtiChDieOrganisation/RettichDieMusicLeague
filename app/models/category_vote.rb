class CategoryVote < ApplicationRecord
  belongs_to :category_submission
  belongs_to :voter, class_name: "User"

  validate :max_votes_per_user

  private

  def max_votes_per_user
    return unless category_submission && voter_id

    existing_votes = CategoryVote.where(category_submission_id: category_submission_id, voter_id: voter_id)
    existing_votes = existing_votes.where.not(id: id) if id
    if existing_votes.count >= 2
      errors.add(:base, "You can only cast up to 2 votes for a category.")
    end
  end
end
