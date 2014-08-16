class Seller < Account
  belongs_to :person, touch: true
end
