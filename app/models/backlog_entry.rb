class BacklogEntry < ActiveRecord::Base
  acts_as_list
  belongs_to :project

  validates :title, :presence => true 
end
