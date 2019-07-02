class Api::V1::AlertsController < Api::V1::BaseController

  def index
    alerts = Alert.kept
    render json: alerts, each_serializer: Api::V1::AlertSerializer
  end

  def show
    alert = Alert.kept.find(params[:id])
    render json: alert, serializer: Api::V1::AlertSerializer
  end

  def create
    alert = Alert.find_or_initialize_by(
      source: Source.find_or_initialize_by(slug: alert_params[:source]),
      finding_id: alert_params[:finding_id],
      target: alert_params[:target]
    )

    alert_params[:urls].map do |url|
      alert.urls.find_or_initialize_by(name: url[:name], url: url[:url])
    end if alert_params[:urls]

    alert_params[:key_values].map do |kv|
      alert.key_values.find_or_initialize_by(key: kv[:key], value: kv[:value])
    end if alert_params[:key_values]

    alert.last_detected_at = alert_params[:last_detected_at]
    alert.finding = alert_params[:finding]
    alert.severity_external = Severity.friendly.find(alert_params[:severity])
    alert.agent_id = alert_params[:agent_id]
    alert.run_id = alert_params[:run_id]

    if alert.persisted?
      alert.detail = alert_params[:detail]
      unless alert_params[:no_repeat]
        alert.count = alert_params[:count].nil? ? alert.count + 1 : alert_params[:count]
        alert.audits.build(created_at: alert_params[:detected_at], kind: 'detected', action: 'Repeat Alert', icon: 'fas fa-exclamation-circle')
      end
    else
      alert.count = alert_params[:count].nil? ? 1 : alert_params[:count]
      alert.name = alert_params[:name]
      alert.detail = alert_params[:detail]
      alert.first_detected_at = alert_params[:first_detected_at]
      alert.notes = alert_params[:notes]
      alert.kind = Kind.friendly.find(alert_params[:kind])
      alert.family = Family.friendly.find(alert_params[:family])
      alert.severity_internal = Severity.friendly.find(alert_params[:severity])
      alert.departments << alert_params[:departments].map { |d| Department.friendly.find(d) } if alert_params[:departments]
    end

    alert.save!
    render json: alert, serializer: Api::V1::AlertSerializer
  end

  def obsolete
    source = Source.kept.find_by(slug: alert_params[:source])
    alerts = source.alerts.kept.verified.or(Alert.unverified). \
      where(agent_id: alert_params[:agent_id]). \
      where.not(run_id: alert_params[:run_id]). \
      each(&:obsolete!)

    render json: alerts, each_serializer: Api::V1::AlertSerializer
  end

  private

  def alert_params
    params.permit(
      :name,
      :target,
      :detail,
      :notes,
      :finding,
      :finding_id,
      :first_detected_at,
      :last_detected_at,
      :kind,
      :family,
      :source,
      :severity,
      :no_repeat,
      :count,
      :agent_id,
      :run_id,
      urls: [:name, :url],
      key_values: [:key, :value],
      departments: []
    )
  end

end
