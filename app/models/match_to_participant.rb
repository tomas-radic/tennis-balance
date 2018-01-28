class MatchToParticipant < ApplicationRecord
  belongs_to :match
  belongs_to :participant, polymorphic: true

  enum meaning: [:attendance, :win, :loss, :retire]

  before_create :set_defaults


  private

  def set_defaults
    self.meaning = :attendance
    self.order_nr ||= self.match.match_to_participants.count
  end
end
