class Week < ApplicationRecord
  TOTAL_POINTS_PER_USER = 6

  belongs_to :season
  has_many :submissions, dependent: :destroy

  after_commit :schedule_playlist_generation, on: [ :create, :update ]

  # Validations
  validates :number, presence: true, uniqueness: { scope: :season_id }, inclusion: { in: 1..10 }
  validates :category, presence: true
  validates :submission_deadline, :voting_deadline, presence: true

  # Phase methods
  def submission_phase?
    Time.current < submission_deadline
  end

  def voting_phase?
    Time.current >= submission_deadline && Time.current < voting_deadline
  end

  def results_phase?
    Time.current >= voting_deadline
  end

  private

  def schedule_playlist_generation
    return unless submission_deadline.present?
    return unless previous_changes.key?("id") || previous_changes.key?("submission_deadline")

    if submission_deadline <= Time.current
      GeneratePlaylistsJob.perform_later(id)
    else
      GeneratePlaylistsJob.set(wait_until: submission_deadline).perform_later(id)
    end
  end
end
