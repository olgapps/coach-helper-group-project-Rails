class Player < ApplicationRecord
  # rubocop: disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :events
  # rubocop: enable Rails/HasAndBelongsToMany
  belongs_to :user
  enum trained_in: %i[club country europe world]
  validates :name, :surname, :birth_date, :trained_in, presence: true
  validates :name, format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/, message: 'only allows letters' }
  validates :surname, format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/, message: 'only allows letters' }
  validates :yellow_cards, numericality: { only_integer: true }
  validates :yellow_cards, numericality: { less_than_or_equal_to: 4, greater_than_or_equal_to: 0, only_integer: true }
  validates :number, numericality: { less_than_or_equal_to: 99, greater_than_or_equal_to: 0, only_integer: true }
  validates :number, uniqueness: { scope: :user_id }

  def self.suspend(params)
    params[:yellow_cards] += 1
    return params if params[:yellow_cards] != 4

    params[:yellow_cards] = 0
    params[:suspended] = true
    params
  end

  def self.remove_players_suspension_after_match(players, user_id)
    if players.nil? { nil }
    else
      Player.all.find_each do |player|
        if player.user_id == user_id && !players.include?(player) { Player.update(player.id, suspended: false) }
        end
      end
    end
  end
end
