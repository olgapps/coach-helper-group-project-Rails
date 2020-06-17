class Event < ApplicationRecord
  belongs_to :user
  # rubocop: disable Rails/HasAndBelongsToMany
  has_and_belongs_to_many :players, -> { distinct }
  has_and_belongs_to_many :play_books, -> { distinct }
  # rubocop: enable Rails/HasAndBelongsToMany
  # validates :players, uniqueness: true
  # validates :play_books, uniqueness: true
  validates :opponent, :event_date, presence: true
  validates :opponent, format: { with: /\A[^0-9`!@#\$%\^&*+_=?]+\z/, message: 'only allows letters' }

  def self.importcsv(file, id)
    return unless file

    items = []
    CSV.foreach(file.path, headers: true) do |row|
      event_hash = row.to_hash
      items << { opponent: event_hash['Opponent'], event_date: event_hash['Date'], user_id: id }
    end
    Event.import(items)
  end
end
