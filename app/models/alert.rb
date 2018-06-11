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

    event :verify, after: :set_verified_at do
      transitions from: [:unverified], to: :verified
    end

    event :reject, after: :set_rejected_at do
      transitions from: [:verified, :unverified], to: :rejected
    end

    event :resolve, after: :set_resolved_at do
      transitions from: [:unverified, :verified], to: :resolved
    end
  end

  scope :state, ->(state) { where('state IN (?)', state) }
  scope :kind, ->(kind) { joins(:kind).where('kinds.slug IN (?)', kind) }
  scope :family, ->(family) { joins(:family).where('families.slug IN (?)', family) }
  scope :severity, ->(severity) { joins(:severity_internal).where('severities.slug IN (?)', severity) }
  scope :source, ->(source) { joins(:source).where('sources.slug IN (?)', source) }
  scope :department, ->(department) { joins(:departments).where('departments.slug IN (?)', department) }
  scope :user, ->(user) { joins(:users).where('users.slug IN (?)', user) }

  private

  def set_rejected_at
    update_attribute(:rejected_at, Time.now.utc)
  end

  def set_resolved_at
    update_attribute(:resolved_at, Time.now.utc)
  end

  def set_verified_at
    update_attribute(:verified_at, Time.now.utc)
  end

  def log_create_event
    audits.create(kind: 'detected', action: 'Created Alert', icon: 'fas fa-exclamation-circle')
  end

  def log_status_change
    icon = 'fas fa-check-circle' if aasm.to_state == 'resolved'
    audits.create(kind: 'status change', action: "Set to #{aasm.to_state}", icon: icon)
  end

  def touch_source_last_seen
    source.touch(:last_seen_at)
    source.touch(:last_alert_at)
  end

end
