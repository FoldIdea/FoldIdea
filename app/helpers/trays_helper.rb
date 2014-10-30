require 'prawn/measurement_extensions'
require 'open-uri'

module TraysHelper
  def tray_gap(val)
    gap = val.kind_of?(Tray) ? val.gap_percent : val.to_f
    (gap * 100).round
  end

  def render_tray_pdf(pdf, tray, start_y, start_x = 0)
    tray_width = tray.file_size.mm
    tray_height = tray.rank_size.mm
    start_y = start_y - (40.mm + tray_height)
    # todo - get a background image, but for now, just use dummy
    bg_image = { file: 'app/assets/images/grass_background_yellow.jpg', width:35.mm, height:35.mm }
    tray_background pdf, start_x, start_y, tray_width, tray_height, bg_image
    tray_tabs_with_braces pdf, :bottom, start_x, start_y, tray_width
    tray_tabs_with_braces pdf, :top, start_x, start_y + 20.mm + tray_height, tray_width
    tray_tabs_with_braces pdf, :left, start_x, start_y + 20.mm, tray_height
    tray_tabs_with_braces pdf, :right, start_x + 20.mm + tray_width, start_y + 20.mm, tray_height
  end

  def tray_tabs_with_braces(pdf, position, start_x, start_y, dimension)
    tray_tabs pdf, position, start_x, start_y, dimension
    if [ :top, :bottom ].include?(position)
      brace_top_style = position == :bottom ? :valley : :cut
      brace_bottom_style = position == :top ? :valley : :cut
      fc = pdf.fill_color
      pdf.fill_color('FFFFFF')
      pdf.fill { pdf.rectangle [ start_x + 15.mm, start_y + 20.mm ], 5.mm, 20.mm }
      fold_rectangle pdf, [ start_x + 15.mm, start_y ], 5.mm, 20.mm, top: brace_top_style, bottom: brace_bottom_style, right: :skip
      pdf.fill { pdf.rectangle [ start_x + 20.mm + dimension, start_y + 20.mm ], 5.mm, 20.mm }
      fold_rectangle pdf, [ start_x + 20.mm + dimension, start_y ], 5.mm, 20.mm, top: brace_top_style, bottom: brace_bottom_style, left: :skip
      pdf.fill_color(fc)
    else
      offset_sx = position == :right ? 5.mm : 0
      offset_ex = position == :left ? 15.mm : 20.mm
      fold_line pdf, [ start_x + offset_sx, start_y ], [ start_x + offset_ex, start_y ]
      fold_line pdf, [ start_x + offset_sx, start_y + dimension ], [ start_x + offset_ex, start_y + dimension ]
    end
  end

  def tray_tabs(pdf, position, start_x, start_y, dimension)
    styles = {}
    fold_offsets = [ 10, 5 ]
    width = dimension
    height = 20.mm
    case position
      when :top
        start_x += 20.mm
        styles[:bottom] = :valley
        fold_offsets = [ 5, 5 ]
      when :bottom
        start_x += 20.mm
        styles[:top] = :valley
      when :left
        styles[:right] = :valley
        styles[:top] = styles[:bottom] = :skip
        width = 20.mm
        height = dimension
      when :right
        styles[:left] = :valley
        styles[:top] = styles[:bottom] = :skip
        width = 20.mm
        height = dimension
        fold_offsets = [ 5, 5 ]
    end
    fold_rectangle pdf, [ start_x, start_y ], width, height, styles
    offset_mm = 0
    fold_offsets.each_with_index do |offset,idx|
      offset_mm += offset.mm
      offset_sx, offset_sy, offset_ex, offset_ey = case position
        when :top, :bottom then [ 0, offset_mm, width, offset_mm ]
        when :left, :right then [ offset_mm, 0, offset_mm, height ]
      end
      fold_line pdf, [ start_x+offset_sx, start_y+offset_sy ], [ start_x+offset_ex, start_y+offset_ey ], :mountain
    end
  end

  def fold_line(pdf, corner1, corner2, style = :cut)
    case (style || :cut)
      when :valley
        pdf.dash(3.5, space: 2)
      when :mountain
        pdf.dash(1.5, space: 1.2)
      else
        pdf.undash
    end
    pdf.line corner1, corner2
    pdf.stroke
    pdf.undash
  end

  def fold_rectangle(pdf, corner, width, height, styles = {})
    x = corner[0]
    y = corner[1]
    lw = pdf.line_width
    pdf.line_width(1)
    [ :left, :top, :right, :bottom ].each do |edge|
      next if styles[edge] == :skip
      case edge
        when :left then fold_line pdf, [x, y], [x, y+height], styles[edge]
        when :top then fold_line pdf, [x, y+height], [x+width, y+height], styles[edge]
        when :right then fold_line pdf, [x+width, y+height], [x+width, y], styles[edge]
        when :bottom then fold_line pdf, [x+width, y], [x, y], styles[edge]
      end
    end
    pdf.line_width = lw
  end

  def tray_background(pdf, start_x, start_y, tray_width, tray_height, bg_image)
    sx = start_x + 10.mm
    sy = start_y + 10.mm
    img = bg_image[:file] || open(bg_image[:source])
    tex = sx + tray_width + 20.mm
    tey = sy + tray_height + 20.mm
    over_x = nil
    over_y = nil
    while sy < tey
      while sx < tex
        pdf.image img, width: bg_image[:width], height: bg_image[:height], :at => [ sx, sy + bg_image[:height] ]
        sx += bg_image[:width]
      end
      over_x = over_x || (sx - tex)
      sx = start_x + 10.mm
      sy += bg_image[:height]
    end
    over_y = sy - tey
    fc = pdf.fill_color
    lc = pdf.stroke_color
    pdf.fill_color('ffffff')
    pdf.stroke_color('ffffff')
    if over_y > 0
      pdf.fill_and_stroke { pdf.rectangle [ start_x + 10.mm, start_y + 30.mm + tray_height + over_y ], tray_width + 20.mm + over_x, over_y }
    end
    if over_x > 0
      pdf.fill_and_stroke { pdf.rectangle [ start_x + 30.mm + tray_width, start_y + 30.mm + tray_height ], over_x, tray_height + 20.mm }
    end
    pdf.fill_and_stroke { pdf.rectangle [ start_x + 10.mm, start_y + 20.mm ], 5.mm, 10.mm }
    pdf.fill_and_stroke { pdf.rectangle [ start_x + 10.mm, start_y + 30.mm + tray_height ], 5.mm, 10.mm }
    pdf.fill_and_stroke { pdf.rectangle [ start_x + 25.mm + tray_width, start_y + 20.mm ], 5.mm, 10.mm }
    pdf.fill_and_stroke { pdf.rectangle [ start_x + 25.mm + tray_width, start_y + 30.mm + tray_height ], 5.mm, 10.mm }
    pdf.stroke_color(lc)
    pdf.fill_color(fc)
  end
end
