module BacklogEntriesHelper
  def category_of entry
    category = entry.category
    if category.nil? || category.blank?
      category = I18n.t("backlog_entries.backlog_entry.no_category")
    end
    category
  end
  
  def cuttings_line cuttings
    unless cuttings.empty?
      links = cuttings.collect do |cutting|
        klass = cutting.done ? "done" : ""
        link_to("##{cutting.id} ", cutting, rel: "tooltip", title: cutting.title.to_s, class: klass)
      end
      line = "<br />Zerlegt in: " + links.join(" ")
      line.html_safe
    end
  end
  
  def conjoined_line cuttings
    if cuttings and not cuttings.empty?
      links = cuttings.collect do |cutting|
        klass = cutting.done ? "done" : ""
        link_to("##{cutting.id} ", cutting, rel: "tooltip", title: cutting.title.to_s, class: klass)
      end
      line = "<br />Weitere Teile: " + links.join(" ")
      line.html_safe
    end
  end

end
