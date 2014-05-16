class BaseUnit < ActiveRecord::Base
  has_many :trays, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5, maximum: 100 }
  validates :base_length, presence: true, numericality: { greater_than: 0 }
  validates :base_width, presence: true, numericality: { greater_than: 0 }

  def to_param
    "#{id}-#{name.parameterize('-')}"
  end
end
