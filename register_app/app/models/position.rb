class Position < ActiveRecord::Base
    has_many :events, dependent: :restrict_with_error 

  	validates_numericality_of :lat, :less_than_or_equal_to => 90, :greater_than_or_equal_to => -90 
  	validates_numericality_of :lng, :less_than_or_equal_to => 180, :greater_than_or_equal_to => -180
end
