class Message < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	acts_as_taggable
	
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/,
  size: { in: 0..10.kilobytes }
  
  
  
  def self.search(query)
   		where("title like ?", "%#{query}%") 
  end
end
