class Message < ApplicationRecord
  # Constants
  VALID_MESSAGE_TYPES = %w[system user ai].freeze

  # Validations
  validates :content, presence: true
  validates :token_count, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :message_type, presence: true, inclusion: { in: VALID_MESSAGE_TYPES }
  validates :position, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, on: :create
  validates :active, inclusion: { in: [true, false] }

  # Scopes
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :ordered, -> { order(position: :asc) }
  scope :by_type, ->(type) { where(message_type: type) }

  # Callbacks
  before_validation :count_tokens, if: :content_changed?
  before_validation :set_position, on: :create

  private

  def count_tokens
    # Simple token counting logic - split by whitespace
    # TODO: Replace with more sophisticated token counting based on the AI model being used
    self.token_count = content.to_s.split(/\s+/).size
  end

  def set_position
    self.position = Message.maximum(:position).to_i + 1
  end
end
