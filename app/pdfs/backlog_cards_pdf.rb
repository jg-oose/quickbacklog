require "prawn/measurement_extensions"

class BacklogCardsPdf < Prawn::Document
  def initialize
    super page_size: "A4", page_layout: :landscape, margin: 0.mm, skip_page_creation: true
    font_size 10
  end
  
  def build_document(entries)
    origins = [nil, [5.mm, 205.mm], [154.mm, 205.mm], [5.mm, 100.mm], [154.mm, 100.mm]].cycle
    
    entries.each do |entry|
      origin = origins.next
      if origin.nil?
        prepare_new_page
        origin = origins.next
      end
      draw_card entry, origin
    end
  end

private
  def prepare_new_page
        start_new_page template: File.dirname(__FILE__)+ "/CardTemplate.pdf"
  end
    
  def draw_card(entry, origin)
    bounding_box [origin.first, origin.last], width: 139.mm, height: 95.mm do
      fill_color 77, 71, 66, 40
      draw_id entry
      draw_info entry
      draw_estimate entry
      text_box "#{entry.title}", at: [1.mm, 78.mm], width: 112.mm, height: 18.mm, size: 18, style: :bold, overflow: :shrink_to_fit
      draw_description entry
      draw_timestamp
    end
  end

  def draw_id entry
#    fill_rectangle [1.mm, 95.mm], 26.mm, 15.mm
      text_box "##{entry.id}", at: [1.mm, 95.mm], width: 26.mm, height: 15.mm, size: 24, align: :center, valign: :center
  end

  def draw_info entry
    the_info = []
    if entry.category
      the_info << "#{entry.category}\n"
    else
      the_info << "No category given\n"
    end
    
#    if entry.part_of
#      the_info << "##{entry.part_of.id} - #{entry.part_of.title}"
#    end

#      fill_rectangle [29.mm, 95.mm], 84.mm, 15.mm
    text_box the_info.join, at: [31.mm, 95.mm], width: 82.mm, height: 15.mm, size: 12, valign: :center
  end

  def draw_estimate entry
    estimate = entry.size ? entry.size : "--"
#    fill_rectangle [114.mm, 95.mm], 24.mm, 15.mm
    text_box "#{estimate}", at: [114.mm, 95.mm], width: 24.mm, height: 15.mm, size: 18, align: :center, valign: :center
  end
  
  def draw_description entry
    excess = text_box entry.description, at: [1.mm, 60.mm], width: 112.mm, height: 58.mm
    if !excess.empty?
      draw_text "...", at: [106.mm, 2.mm], size: 16, style: :bold
    end
  end

  def draw_timestamp
    text_box Date.today.to_s, at: [114.mm, 5.5.mm], width: 24.mm, height: 3.mm, size: 8, align: :center, valign: :center
  end

end