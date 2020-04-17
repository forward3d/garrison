class RunsController < ApplicationController

  def index
    @runs = Run.kept.includes(:agent)
    @pagy, @runs = pagy(@runs.order('ended_at desc'), items: 100)
  end

end
