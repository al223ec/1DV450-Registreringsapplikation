class Event < ActiveRecord::Base
	belongs_to :position
	
	has_many :event_tags
  	has_many :tags, through: :event_tags
	
	validates :position_id, presence: true

end
