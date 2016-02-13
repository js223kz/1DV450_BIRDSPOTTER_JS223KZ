class Api < ActiveRecord::Base
    belongs_to :user
    validates :application_name, presence:true, length: { minimum: 4, maximum: 70 }
    validates :application_key, presence:true, length: {minimum: 20, maximum: 255}
end
