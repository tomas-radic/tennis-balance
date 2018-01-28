class GameSet < ApplicationRecord

  belongs_to :match

  serialize :games, Array
  serialize :tiebreak, Array
  serialize :supertiebreak, Array

  after_save :evaluate_match


  private

  def evaluate_match
    self.match.evaluate!
  end
end
