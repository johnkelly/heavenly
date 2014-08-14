class AuthProvider < ActiveRecord::Base
  validates :type,                presence: true
  validates :person_id,           presence: true
  validates :provider_person_id,  presence: true
  validates :token,               presence: true
  validates :expiration,          presence: true
  validates :link,                presence: true
  validates :verified,            inclusion: [true, false]
end
