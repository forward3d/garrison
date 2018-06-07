class Alert < ApplicationRecord

  include AASM
  include Discard::Model

  belongs_to :kind
  belongs_to :family
  belongs_to :source

  belongs_to :severity_internal, class_name: 'Severity'
  belongs_to :severity_external, class_name: 'Severity'

  has_many :alert_departments, dependent: :destroy
  has_many :alert_users, dependent: :destroy

  has_many :departments, through: :alert_departments
  has_many :users, through: :alert_users

  has_many :audits, dependent: :destroy
  has_many :urls, dependent: :destroy
  has_many :key_values, dependent: :destroy

  validates :state, presence: true
  validates :kind, presence: true
  validates :family, presence: true
  validates :source, presence: true
  validates :name, presence: true
  validates :finding, presence: true
  validates :finding_id, presence: true
  validates :first_detected_at, presence: true

  after_create :touch_source_last_seen
  after_create :log_create_event

  aasm column: 'state' do
    after_all_transitions :log_status_change

    state :unverified, initial: true
    state :verified
    state :rejected
    state :resolved

    event :verify do
      transitions from: [:unverified], to: :verified
    end

    event :reject do
      transitions from: [:verified, :unverified], to: :rejected
    end

    event :resolve do
      transitions from: [:unverified, :verified], to: :resolved
    end
  end

  private

  def log_create_event
    audits.create(kind: 'detected', action: 'Created Alert', icon: 'fas fa-exclamation-circle')
  end

  def log_status_change
    audits.create(kind: 'status change', action: "Set to #{aasm.to_state}")
  end

  def touch_source_last_seen
    source.touch(:last_seen_at)
    source.touch(:last_alert_at)
  end

end
