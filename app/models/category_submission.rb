class CategorySubmission < ApplicationRecord
  belongs_to :group
  belongs_to :user
  has_many :category_votes, dependent: :destroy

  validates :title, :subtitle, presence: true
end
