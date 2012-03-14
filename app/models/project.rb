class Project < ActiveRecord::Base
  has_many :backlog_entries, :order => :position
  serialize :estimation_scale, Hash

  validates :name, :presence => true 
end
