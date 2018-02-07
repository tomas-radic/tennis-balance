class MatchToParticipant < ApplicationRecord

  validates :order_nr, presence: true, inclusion: { in: 0..1 }
  validates :participant_type, presence: true

  belongs_to :match
  belongs_to :participant, polymorphic: true

  before_validation :set_defaults, on: :create


  private

  def set_defaults
    self.order_nr ||= self.match.match_to_participants.size - 1
  end
end
