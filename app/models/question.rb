class Question < ActiveRecord::Base
  belongs_to :product,  touch: true
  belongs_to :asker,    foreign_key: :asker_id,   class_name: 'Person'
  belongs_to :replier,  foreign_key: :replier_id, class_name: 'Person'

  validates :product_id,  presence: true
  validates :question,    presence: true
  validates :asker_id,    presence: true
end
