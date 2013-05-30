class Event < ActiveRecord::Base
  belongs_to :user
  has_many :event_attendances
  has_many :users, :through => :event_attendaces
end
