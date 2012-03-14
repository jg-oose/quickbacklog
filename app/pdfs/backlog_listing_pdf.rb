require "prawn/measurement_extensions"

class BacklogListingPdf < Prawn::Document
  COLOR_RULE = "AAAAAA"
  COLOR_TITLE = [77, 71, 66, 60]
  COLOR_INFO = [77, 71, 66, 20]
  COLOR_DESC = [77, 71, 66, 60]
  
  def initialize
    super
    font_size 10
  end
  
  # Maybe not do that inheritance thing but a true factory
  # And maybe we could use a real simple yaml file to draw the table cells and get the template pdf
  def build_document(entries)
    the_heading = [
      {text: "Backlog Listing ", font: "Courier-Bold", size: 24, style: [:bold]},
      {text: Date.today.to_s, font: "Courier-Bold", size: 14, style: [:italic]}]
#    text "Backlog Listing", font: "Courier-Bold", size: 24, style: :bold
#    text Date.today.to_s, font: "Courier-Bold", size: 14, style: :italic
    formatted_text the_heading
    move_down 5.mm
    
    entries.each {|entry| draw_entry entry} # Could change this to .map to create cells and then draw in table
    draw_page_numbers    
  end

private
    
  def draw_entry(entry)
    group do
      stroke_color COLOR_RULE
      stroke_horizontal_rule
      pad(2.mm) {
        saved_cursor = cursor
        indent 0.mm, 175.mm do
          draw_id entry
          stroke_line [2.mm, cursor], [1.6.cm, cursor]
          move_down 2.mm
          draw_estimate entry
        end
        move_cursor_to saved_cursor
        indent 2.0.cm do
          draw_title entry
          draw_info entry
          draw_description entry
        end
      }
   end
  end
  
  def draw_id entry
    fill_color COLOR_TITLE
    text "<sup>#</sup>#{entry.id}", inline_format: true, align: :right, size: 16, style: :bold
  end
  
  def draw_estimate entry
    fill_color COLOR_TITLE
    text "#{entry.size ? entry.size : '--'}", align: :right, size: 14
  end
  
  def draw_title entry
    fill_color COLOR_TITLE
    text "#{entry.title}", size: 14, leading: -2, style: :bold
  end
  
  def draw_info entry
    the_info = []
    if entry.category
      the_info << "#{entry.category}"
    else
      the_info << "No category given"
    end
    
#    if entry.part_of
#      the_info << " | ##{entry.part_of.id} - #{entry.part_of.title}"
#    end

    fill_color COLOR_INFO
    text the_info.join, size: 8, leading: 4 
  end
  
  def draw_description entry
    fill_color COLOR_DESC
    text entry.description, size: 10
  end
  
  def draw_page_numbers
    options = { :at => [bounds.right - 5.cm, 0],
                :width => 5.cm,
                :align => :right,
                :start_count_at => 1,
                :color => "aaaaaa" }
    number_pages "<page> of <total>", options
  end
end