class BacklogEntry < ActiveRecord::Base
  acts_as_list
  belongs_to :project
  has_many :cuttings, :class_name => "BacklogEntry", :foreign_key => :cut_from_id, :order => :position
  belongs_to :cut_from, :class_name => "BacklogEntry", :foreign_key => :cut_from_id

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

  def conjoined_cuttings
    conjoins = nil
    if cut_from
      if id
        conjoins = cut_from.cuttings.where("id != ?", id)
      else
        conjoins = cut_from.cuttings
      end 
    end
    return conjoins
  end

private
  def map_size
    self.size_val = size_scale[@size] # TODO shouldn't that be [size]
  end

end
