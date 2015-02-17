class Position < ActiveRecord::Base
	has_many :events, dependent: :restrict_with_error 
  	before_destroy :has_event?

  	validates_numericality_of :lat, :less_than_or_equal_to => 90, :greater_than_or_equal_to => -90 
  	validates_numericality_of :lng, :less_than_or_equal_to => 180, :greater_than_or_equal_to => -180

  	private
  		def has_event?
  			unless Event.where("position_id = ?", self.id) == nil
  				return false
  			end
  		end
end
