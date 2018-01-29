class Match < ApplicationRecord

  validates :winning_participant_order_nr, :retired_participant_order_nr, numericality: { only_integer: true, allow_nil: true }, inclusion: { in: 0..1, allow_nil: true }
  validates :date_played, presence: true

  has_many :game_sets, dependent: :destroy
  has_many :match_to_participants, dependent: :destroy, before_add: :validate_participants_count
  has_many :player_participants, through: :match_to_participants, source: :participant, source_type: 'Player'
  has_many :pair_participants, through: :match_to_participants, source: :participant, source_type: 'Pair'
  belongs_to :tournament, optional: true
  belongs_to :season, optional: true
  belongs_to :user, optional: true # not validated, if user is deleted, records are nullified

  before_create :set_defaults
  after_save :evaluate!, if: Proc.new { 
    self.saved_change_to_attribute?('completed') || self.saved_change_to_attribute('retired_participant_order_nr')
  }

  MAX_PARTICIPANTS_COUNT = 2


  def evaluate!
    unless self.completed?
      # update attributes one-by-one, otherwise 'completed' attribute is also considered as updated
      # it triggers after_save callback again and again
      self.update_attribute(:winning_participant_order_nr, nil)
      return
    end

    # Set winner if someone retired
    if self.retired_participant_order_nr.present?   # can only be nil, 0 or 1
      self.update_attribute(:winning_participant_order_nr, (retired_participant_order_nr - 1).abs)
      return
    end

    sets_won = { 0 => 0, 1 => 0 }
    
    self.game_sets.each_with_index do |game_set, i|
      return if i >= self.max_game_sets
      won = game_set.winner_order_nr
      next if won.nil?
      sets_won[won] += 1
    end

    if sets_won[0] != sets_won[1]
      self.update_attribute(:winning_participant_order_nr, sets_won.max_by { |k, v| v }[0])
    else
      self.update_attributes(:winning_participant_order_nr, nil) unless self.winning_participant_order_nr.nil?
    end
  end

  private

  def set_defaults
    self.max_game_sets ||= 3
  end

  def validate_participants_count(match_to_participant)
    raise 'Maximum participants count violated' if self.match_to_participants.size >= MAX_PARTICIPANTS_COUNT
  end
end


