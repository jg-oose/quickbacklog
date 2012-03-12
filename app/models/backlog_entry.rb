class BacklogEntry < ActiveRecord::Base
  acts_as_list

  validates :title, :presence => true 
end
