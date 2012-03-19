class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def default_url_options(options={})
    { :locale => I18n.locale }
  end
  
  def project_from_session
    prj = Project.first
    unless prj
      prj = Project.create(
        name: "Dein naechstes Projekt!",
        vision: "Beschreib die Essenz Deines Projekt in wenigen Worten ... Template",
        size_scale: {
          "0" => 0, "1" => 1, "2" => 2, "3" => 3, "5" => 5,
          "8" => 8, "13" => 13, "21" => 21, "40" => 40, "100" => 100},
        entry_template_text: "_Story_\n...\n\n_Howto Demo_\n...\n\n_Value_\n...\n\n_Risks_\n...\n\n_What else you need_...")
    end
    return prj
  end
end
