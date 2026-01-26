class GenerateLikedSongsPlaylistJob < ApplicationJob
  queue_as :default

  def perform(group_id, user_id)
    group = Group.find(group_id)
    user = User.find(user_id)

    liked_submissions = Submission.joins(:likes, week: :season)
                                  .where(seasons: { group_id: group.id })
                                  .where(likes: { user_id: user.id })
                                  .distinct

    playlist_generator = PlaylistGenerator.new(user: user)
    playlist_generator.generate(
      name: "#{group.name} - Liked Songs",
      tracks: liked_submissions.map(&:tidal_id).compact
    )
  end
end
