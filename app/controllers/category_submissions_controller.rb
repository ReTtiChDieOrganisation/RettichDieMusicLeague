class CategorySubmissionsController < ApplicationController
  before_action :set_group
  before_action :require_group_membership
  before_action :require_group_admin, only: :apply_to_week

  def create
    @category_submission = @group.category_submissions.build(category_submission_params)
    @category_submission.user = current_user

    if @category_submission.save
      redirect_to group_path(@group), notice: "Category submitted!"
    else
      redirect_to group_path(@group), alert: @category_submission.errors.full_messages.to_sentence
    end
  end

  def apply_to_week
    @category_submission = @group.category_submissions.find(params[:id])
    season_id = params[:season_id]
    week_id = params[:week_id]
    if season_id.blank? || week_id.blank?
      redirect_to group_path(@group), alert: "Please select a season and week."
      return
    end

    season = @group.seasons.find(season_id)
    week = season.weeks.find(week_id)

    if week.update(category: @category_submission.title, subtitle: @category_submission.subtitle)
      redirect_to group_path(@group), notice: "Updated Week #{week.number} in Season #{season.number}."
    else
      redirect_to group_path(@group), alert: week.errors.full_messages.to_sentence
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def category_submission_params
    params.require(:category_submission).permit(:title, :subtitle)
  end
end
