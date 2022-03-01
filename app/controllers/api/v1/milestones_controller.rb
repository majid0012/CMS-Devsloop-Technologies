class Api::V1::MilestonesController < ApplicationController
  before_action :set_milestone, only: [:update, :show, :destroy]
  before_action :set_project, only: [:index, :create]

  def index
    @milestones = @project.milestones.order("created_at DESC")
    render json: {
      milestones: MilestoneSerializer.new(@milestones).serializable_hash
    }
  end

  def show
    render status: :ok, json: {
      milestone: MilestoneSerializer.new(@milestone).serializable_hash
    }
  end

  def create
    @milestone = @project.milestones.new(milestone_params)
    if @milestone.save
      render json: {
        milestone: MilestoneSerializer.new(@milestone).serializable_hash
      }
    else
      error = @milestone.errors.full_messages.to_sentence
      render status: :unprocessable_entity, json: { error: error  }
    end
  end

  def update
    if @milestone.update!(milestone_params)
      render json: {
        milestone: MilestoneSerializer.new(@milestone).serializable_hash
      }

    else
      render status: :unprocessable_entity, json: { notice: 'milestone not updated' }
    end
  end

  def destroy
    if @milestone.destroy
      head :no_content, status: :ok
    else
      render status: :unprocessable_entity, json: { notice: 'milestone not deleted' }
    end
  end

  private

  def set_milestone
    @milestone = Milestone.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def milestone_params
    params.require(:milestone).permit(:title, :description, :budget, :project_id)
  end
end
