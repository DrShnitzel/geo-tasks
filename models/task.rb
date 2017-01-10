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
end
