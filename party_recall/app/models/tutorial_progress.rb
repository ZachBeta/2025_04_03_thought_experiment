class TutorialProgress < ApplicationRecord
  # Constants
  VALID_STAGES = %w[welcome memory_basics advanced completion].freeze

  # Validations
  validates :current_stage, presence: true, inclusion: { in: VALID_STAGES }
  validates :session_id, presence: true, uniqueness: true
  validates :completed_steps, presence: true

  # Callbacks
  before_validation :ensure_completed_steps

  # Scopes
  scope :active_sessions, -> { where(current_stage: VALID_STAGES[0..-2]) } # Excludes completed tutorials
  scope :completed, -> { where(current_stage: VALID_STAGES.last) }

  # Instance methods
  def mark_step_complete(stage, step)
    self.completed_steps ||= {}
    self.completed_steps[stage] ||= []
    self.completed_steps[stage] << step unless completed_steps[stage].include?(step)
    save
  end

  def current_stage_complete?
    return false unless completed_steps && completed_steps[current_stage]
    case current_stage
    when 'welcome'
      completed_steps[current_stage].include?('intro') && completed_steps[current_stage].include?('basics')
    when 'memory_basics'
      completed_steps[current_stage].include?('theory') && completed_steps[current_stage].include?('practice')
    when 'advanced'
      completed_steps[current_stage].include?('techniques') && completed_steps[current_stage].include?('mastery')
    when 'completion'
      completed_steps[current_stage].include?('final')
    else
      false
    end
  end

  def advance_stage
    return false unless current_stage_complete?
    current_stage_index = VALID_STAGES.index(current_stage)
    return false if current_stage_index.nil? || current_stage_index >= VALID_STAGES.length - 1
    
    self.current_stage = VALID_STAGES[current_stage_index + 1]
    save
  end

  def progress_percentage
    total_steps = {
      'welcome' => 2,
      'memory_basics' => 2,
      'advanced' => 2,
      'completion' => 1
    }

    completed_count = completed_steps.sum { |stage, steps| steps.size }
    total_count = total_steps.values.sum

    (completed_count.to_f / total_count * 100).round
  end

  # Class methods
  def self.find_or_create_session(session_id)
    find_or_create_by!(session_id: session_id) do |progress|
      progress.current_stage = VALID_STAGES.first
      progress.completed_steps = {}
    end
  end

  private

  def ensure_completed_steps
    self.completed_steps ||= {}
  end
end
