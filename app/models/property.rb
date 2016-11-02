class Property < ActiveRecord::Base
    validates :property_name, presence: true, length: {minimum: 4, maximun: 30}
    validates :description, presence: true
    validates :owner_id, presence: true
end