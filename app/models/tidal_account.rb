class TidalAccount < ApplicationRecord
  belongs_to :user

  validates :access_token, presence: true

  def expired?
    expires_at.present? && expires_at <= Time.current
  end
end
