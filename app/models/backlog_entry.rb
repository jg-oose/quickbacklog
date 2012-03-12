class BacklogEntry < ActiveRecord::Base
  validates :title, :presence => true 
end
