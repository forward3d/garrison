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

    alert.last_detected_at = alert_params[:detected_at]
    alert.finding = alert_params[:finding]
    alert.severity_external = Severity.friendly.find(alert_params[:severity])

    if alert.persisted?
      alert.detail = alert_params[:detail]
      alert.count += 1
      alert.audits.build(created_at: alert_params[:detected_at], kind: 'detected', action: 'Repeat Alert', icon: 'fas fa-exclamation-circle')
    else
      alert.name = alert_params[:name]
      alert.detail = alert_params[:detail]
      alert.notes = alert_params[:notes]
      alert.first_detected_at = alert_params[:detected_at]
      alert.kind = Kind.friendly.find(alert_params[:kind])
      alert.family = Family.friendly.find(alert_params[:family])
      alert.severity_internal = Severity.friendly.find(alert_params[:severity])
    end

    alert.save!
    render json: alert, serializer: Api::V1::AlertSerializer
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
      :detected_at,
      :kind,
      :family,
      :source,
      :severity,
      urls: [:name, :url],
      key_values: [:key, :value]
    )
  end

end
