class Event < ActiveRecord::Base
	belongs_to :position
	belongs_to :end_user
	belongs_to :application
	
	has_many :event_tags
  	has_many :tags, through: :event_tags
	
	default_scope -> { order(created_at: :desc) }

	validates :position_id, presence: true
	validates :end_user_id, presence: true
	validates :content, presence: true, length: { maximum: 140 }
end
