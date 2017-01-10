# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Doe'
    token 'user_auth_token'
  end
end
