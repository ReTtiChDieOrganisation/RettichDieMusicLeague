class Like < ApplicationRecord
  belongs_to :submission
  belongs_to :user

  validates :user_id, uniqueness: { scope: :submission_id, message: "already liked this submission" }
end
