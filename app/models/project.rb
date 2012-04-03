class Project < ActiveRecord::Base
  has_many :backlog_entries, :order => :position
  serialize :size_scale, Hash

  validates :name, :presence => true 
  
  def new_backlog_entry_from_template
    backlog_entries.build(:description => self.entry_template_text)
  end
  
  def scale_textline
    size_scale.inject("") do |memo, e|
      memo += ", " unless memo.empty?
      memo += "#{e[0]}=#{e[1]}" unless e[0].nil?
      memo
    end
  end
  
  def scale_textline=(line)
    scale = {}
    r = /([[:alnum:]]+)=([[:digit:].]+),? */
    line.scan(r) do |k, v|
      scale.store k.to_s, v.to_f
    end

    if scale.empty?
      line.scan(/([[:digit:]]+),? */) do |v, so_it_doesnt_pass_the_match_obj|
        scale.store v.to_s, v.to_f
      end
    end

    self.size_scale = scale
  end
end
