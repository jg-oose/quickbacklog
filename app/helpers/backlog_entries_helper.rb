module BacklogEntriesHelper
  def category_of entry
    category = entry.category
    if category.nil? || category.blank?
      category = I18n.t("backlog_entries.backlog_entry.no_category")
    end
    category
  end
end
