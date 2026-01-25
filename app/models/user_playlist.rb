class UserPlaylist < ApplicationRecord
  belongs_to :user
  belongs_to :week, optional: true

  validates :name, :tidal_url, presence: true
end
