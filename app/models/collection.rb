class Collection < ApplicationRecord
  has_many :picks
  belongs_to :game
  belongs_to :player

  def spent
    picks.map(&:price).sum || 0
  end
end
