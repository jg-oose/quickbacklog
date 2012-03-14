class Project < ActiveRecord::Base
  has_many :backlog_entries, :order => :position
  serialize :estimation_scale, Hash

  validates :name, :presence => true 
  
  def new_backlog_entry_from_template
    backlog_entries.build(:description => self.entry_template_text)
  end
end
