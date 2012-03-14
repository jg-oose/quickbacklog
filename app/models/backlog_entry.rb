class BacklogEntry < ActiveRecord::Base
  acts_as_list
  belongs_to :project

  validates :title, :presence => true 
  validates :project, :presence => true
  before_validation :map_size
  validate :size_val, :size_in_scale
  
public  
  def size=(size_estimate)
    @size = size_estimate
  end

  def size
    @size || size_scale.key(self.size_val)
  end

  def size_scale
    project.size_scale
  end

  def size_in_scale
    if size and not(size.empty?)
      if not(size_scale.has_key?(size))
        errors.add(:size, "is not included in scale #{size_scale.keys}.")
      end
    end
  end

private
  def map_size
    self.size_val = size_scale[@size]
  end

end
