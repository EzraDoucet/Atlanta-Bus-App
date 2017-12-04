#
class Location < ApplicationRecord
  geocoded_by :full_street_address
  after_validation :geocode

  def full_street_address
    "#{street_address}, #{city}, GA"
  end

  MARTA_CITIES  = [
                   'Atlanta',
                   'Alpharetta',
                   'Avondale Estates',
                   'Chamblee',
                   'Clarkston',
                   'College Park',
                   'Decatur',
                   'Doraville',
                   'Dunwoody',
                   'East Point',
                   'Ellenwood',
                   'Fairburn',
                   'Forest Park',
                   'Hapeville',
                   'Jonesboro',
                   'Lake City',
                   'Lovejoy',
                   'Lithonia',
                   'Morrow',
                   'Palmetto',
                   'Riverdale',
                   'Roswell',
                   'Sandy Springs',
                   'Stone Mountain',
                   'Union City'
                  ]
end
