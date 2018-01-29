class MatchToParticipant < ApplicationRecord

  validates :order_nr, presence: true, inclusion: { in: 0..1, allow_nil: true }
  validates :participant_type, presence: true

  belongs_to :match
  belongs_to :participant, polymorphic: true

  before_create :set_defaults


  private

  def set_defaults
    self.order_nr ||= self.match.match_to_participants.count
  end
end
