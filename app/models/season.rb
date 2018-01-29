class Season < ApplicationRecord

  validates :name, presence: true

  has_many :tournaments, dependent: :nullify
  has_many :matches, dependent: :nullify
  belongs_to :user, optional: true # not validated, if user is deleted, records are nullified

end
