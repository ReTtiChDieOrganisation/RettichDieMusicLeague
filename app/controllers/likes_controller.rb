class LikesController < ApplicationController
  before_action :set_submission
  before_action :require_group_membership
  before_action :check_voting_phase

  def create
    Like.find_or_create_by!(submission: @submission, user: current_user)
    redirect_to group_season_week_path(@group, @season, @week)
  rescue ActiveRecord::RecordInvalid => e
    redirect_to group_season_week_path(@group, @season, @week), alert: e.record.errors.full_messages.join(", ")
  end

  def destroy
    like = Like.find_by(submission: @submission, user: current_user)
    like&.destroy
    redirect_to group_season_week_path(@group, @season, @week)
  end

  private

  def set_submission
    @submission = Submission.find(params[:submission_id])
    @week = @submission.week
    @season = @week.season
    @group = @season.group
  end

  def require_group_membership
    unless @group.members.include?(current_user)
      redirect_to root_path, alert: "You must be a member of this group to access this page."
    end
  end

  def check_voting_phase
    return if @week.voting_phase?

    redirect_to group_season_week_path(@group, @season, @week), alert: "Likes are only available during voting."
  end
end
