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

  def edit
    @alert = Alert.kept.find(params[:id])

    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def update
    @alert = Alert.kept.find(params[:id])
    if @alert.update_attributes(alert_params)
      respond_to do |format|
        format.html { redirect_to alert_url }
        format.json { render json: @alert, status: :created, serializer: Api::V1::AlertSerializer }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.json { render json: @alert.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def alert_params
    params.require(:alert).permit(
      :notes,
      :kind_id,
      :family_id,
      :severity_internal,
      :ticket,
      department_ids: [],
      user_ids: []
    )
  end

end
