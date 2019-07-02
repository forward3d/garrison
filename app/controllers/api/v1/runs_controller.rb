class Api::V1::RunsController < Api::V1::BaseController

  def index
    runs = Run.kept
    render json: runs, each_serializer: Api::V1::RunSerializer
  end

  def show
    run = Run.kept.find(params[:id])
    render json: run, serializer: Api::V1::RunSerializer
  end

  def create
    run = Run.create!(run_params)

    render json: run, serializer: Api::V1::RunSerializer
  end

  def update
    run = Run.kept.find(params[:id])
    run.update_attributes!(run_params)

    render json: run, serializer: Api::V1::RunSerializer
  end

  private

  def run_params
    params.require(:run).permit(
      :agent_id,
      :id,
      :started_at,
      :ended_at,
      :state
    )
  end

end
