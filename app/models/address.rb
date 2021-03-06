class Address < ActiveRecord::Base
  belongs_to :person, touch: true

  validates :person_id,   presence: true
  validates :street1,     presence: true
  validates :city,        presence: true
  validates :region,      presence: true
  validates :postal_code, presence: true
  validates :country,     presence: true
  validates :latitude,    presence: true, numericality: {
    greater_than_or_equal_to: -90,
    less_than_or_equal_to:     90
  }
  validates :longitude,    presence: true, numericality: {
    greater_than_or_equal_to: -180,
    less_than_or_equal_to:     180
  }

  def formatted
    if street2.present?
      "#{street1}\n#{street2}\n#{city}, #{region}, #{postal_code}"
    else
      "#{street1}\n#{city}, #{region}, #{postal_code}"
    end
  end
end
