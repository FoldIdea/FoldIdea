class Tray < ActiveRecord::Base
  belongs_to :base_unit

  VALID_GAP_PERCENTS = [ 0.02, 0.03, 0.05, 0.07 ]

  validates :files, presence: true, numericality: { greater_than: 0 }
  validates :ranks, presence: true, numericality: { greater_than: 0 }
  validates :gap_percent, presence: true, inclusion: { in: VALID_GAP_PERCENTS }

  def to_param
    "#{id}-#{"#{base_unit.name}-#{files}x#{ranks}".parameterize('-')}"
  end

  def file_size
    gap_width = (base_unit.base_width * gap_percent)
    (files * (base_unit.base_width + gap_width) ).round
  end

  def rank_size
    gap_length = (base_unit.base_length * gap_percent)
    (ranks * (base_unit.base_length + gap_length) ).round
  end
end
