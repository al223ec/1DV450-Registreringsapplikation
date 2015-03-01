class Tag < ActiveRecord::Base
	has_many :event_tags
  	has_many :events, through: :event_tags

	validates :name, presence: true, length: { maximum: 40, minimum: 2 },
			uniqueness: { case_sensitive: false }
end