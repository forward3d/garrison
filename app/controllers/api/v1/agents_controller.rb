class Api::V1::AgentsController < Api::V1::BaseController

  def index
    agents = Agent.kept
    render json: agents, each_serializer: Api::V1::AgentSerializer
  end

  def show
    agent = Agent.kept.find(params[:id])
    render json: agent, serializer: Api::V1::AgentSerializer
  end

  def create
    agent = Agent.new
    agent.check = agent_params[:check]
    agent.source = Source.kept.find_by(slug: agent_params[:source])

    agent.save!
    render json: agent, serializer: Api::V1::AgentSerializer
  end

  private

  def agent_params
    params.require(:agent).permit(
      :check,
      :source
    )
  end

end
