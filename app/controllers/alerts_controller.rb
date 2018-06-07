class AlertsController < ApplicationController

  def index
    @alerts = Alert.kept.includes(:severity_internal).order('severities.order desc, last_detected_at desc')
  end

  def show
    @alert = Alert.kept.find(params[:id])
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

end
