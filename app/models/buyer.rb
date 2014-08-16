class Buyer < Account
  belongs_to :person, touch: true
end
