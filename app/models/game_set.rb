class GameSet < ApplicationRecord

  validates :sequence_nr, presence: true, numericality: { greater_than_or_equal_to: 1 }
  
  belongs_to :match

  serialize :games, Array
  serialize :tiebreak, Array
  serialize :supertiebreak, Array

  def winner_order_nr
    result = nil
    return result if self.games.nil?

    won_proc = Proc.new do |player0_score, player1_score|
      if player0_score > player1_score
        0
      elsif player1_score > player0_score
        1
      else
        nil
      end
    end

    if self.games.compact.length == 2   # if two valid numbers contained in 'games'
      result = won_proc.call(games[0], games[1])
    elsif self.tiebreak.compact.length == 2   # if two valid numbers contained in 'tiebreak'
      result = won_proc.call(tiebreak[0], tiebreak[1])
    elsif self.supertiebreak.compact.length == 2  # if two valid numbers contained in 'supertiebreak'
      result = won_proc.call(supertiebreak[0], supertiebreak[1])
    end

    result
  end
end
