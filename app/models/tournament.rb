class Tournament < ApplicationRecord

  has_many :matches, dependent: :nullify
  belongs_to :season, optional: true
  belongs_to :user, optional: true # not validated, if user is deleted, records are nullified

end
