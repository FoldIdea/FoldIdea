module TraysHelper
  def tray_gap(val)
    gap = val.kind_of?(Tray) ? val.gap_percent : val.to_f
    (gap * 100).round
  end
end
