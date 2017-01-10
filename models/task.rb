# frozen_string_literal: true
class Task
  include Mongoid::Document
  include Mongoid::Geospatial

  field :pickup_location, type: Point, spatial: true
  field :delivery_location, type: Point, spatial: true
  field :status, type: String, default: 'New'
  field :assigned_driver, type: String

  validates_inclusion_of :status, in: %w(New Assigned Done)
  validates_presence_of :pickup_location
  validates_presence_of :delivery_location

  def self.tasks_nearby(location)
    maximum_distance = 0.1
    limit = 25
    near(pickup_location: location)
      .max_distance(pickup_location: maximum_distance)
      .limit(limit)
      .to_a
  end
end
