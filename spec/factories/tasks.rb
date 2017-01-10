# frozen_string_literal: true
FactoryGirl.define do
  factory :task do
    pickup_location { [38.8 + rand(-1.0..1.0), 58.0 + rand(-1.0..1.0)] }
    delivery_location { [38.8 + rand(-1.0..1.0), 58.0 + rand(-1.0..1.0)] }
    status 'New'
  end
end
