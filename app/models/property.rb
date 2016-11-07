class Property < ActiveRecord::Base
    belongs_to :user
    validates :property_name, presence: true, length: { minimum: 4, maximum: 30 }
    validates :description, presence: true
    validates :user_id, presence: true
    #validates :owner_id, presence: true
end