class Player < ApplicationRecord

  has_many :owned_matches, foreign_key: :owner_id, class_name: 'Match'
  has_many :match_to_participants, as: :participant, dependent: :destroy
  has_many :matches, through: :match_to_participants
  has_many :pair_to_players, dependent: :destroy
  has_many :pairs, through: :pair_to_players
  belongs_to :user, optional: true # not validated, if user is deleted, records are nullified

  validates :name, presence: true

end
