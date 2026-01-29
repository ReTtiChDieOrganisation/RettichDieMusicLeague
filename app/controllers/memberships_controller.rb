class MembershipsController < ApplicationController
  before_action :set_group
  before_action :require_group_admin
  before_action :set_membership

  def update
    if @membership.update(membership_params)
      redirect_to group_path(@group),
                  notice: "Updated role for #{@membership.user.display_name}."
    else
      redirect_to group_path(@group),
                  alert: @membership.errors.full_messages.to_sentence
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_membership
    @membership = @group.memberships.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:role)
  end
end
