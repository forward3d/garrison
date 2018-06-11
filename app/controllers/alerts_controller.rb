class AlertsController < ApplicationController

  def index
    @alerts = Alert.kept.includes(:severity_internal)

    if params[:alert]
      @filter_params = params.require(:alert).permit(
        states: [],
        severities: [],
        kinds: [],
        families: [],
        sources: [],
        departments: [],
        users: []
      )

      @alerts = @alerts.state(@filter_params[:states])           if @filter_params[:states]
      @alerts = @alerts.severity(@filter_params[:severities])    if @filter_params[:severities]
      @alerts = @alerts.kind(@filter_params[:kinds])             if @filter_params[:kinds]
      @alerts = @alerts.family(@filter_params[:families])        if @filter_params[:families]
      @alerts = @alerts.source(@filter_params[:sources])         if @filter_params[:sources]
      @alerts = @alerts.department(@filter_params[:departments]) if @filter_params[:departments]
      @alerts = @alerts.user(@filter_params[:users])             if @filter_params[:users]
    end

    @alerts = @alerts.order('severities.order desc, last_detected_at desc')
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
