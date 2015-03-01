class Position < ActiveRecord::Base
    has_many :events, dependent: :restrict_with_error

  	validates_numericality_of :lat, :less_than_or_equal_to => 90, :greater_than_or_equal_to => -90
  	validates_numericality_of :lng, :less_than_or_equal_to => 180, :greater_than_or_equal_to => -180

    reverse_geocoded_by :lat, :lng do |obj, results|
      if geo = results.first
          obj.street  = geo.address
          obj.city    = geo.city
          obj.state   = geo.state
          obj.country = geo.country
      end
    end

    after_validation :reverse_geocode #, if: ->(obj){ obj.address.present? and obj.address_changed? }

    def address
      [street, city, state, country].compact.join(', ')
    end
end
