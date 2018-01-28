class Match < ApplicationRecord

  has_many :game_sets, dependent: :destroy
  has_many :match_to_participants, dependent: :destroy
  has_many :player_participants, through: :match_to_participants, source: :participant, source_type: 'Player'
  has_many :pair_participants, through: :match_to_participants, source: :participant, source_type: 'Pair'
  belongs_to :tournament, optional: true
  belongs_to :season, optional: true
  belongs_to :user, optional: true # not validated, if user is deleted, records are nullified

  before_create :set_defaults


  def evaluate!

  end

  private

  def set_defaults
    self.max_game_sets ||= 3
  end
end
