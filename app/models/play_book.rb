class PlayBook < ApplicationRecord
  # rubocop: disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :events
  # rubocop: enable Rails/HasAndBelongsToMany
  validates :name, presence: true
  validates :name, uniqueness: true
end
