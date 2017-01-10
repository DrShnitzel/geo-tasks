# frozen_string_literal: true
class User
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String
  field :role, type: String
  field :token, type: String

  index({ token: 1 }, unique: true)

  def self.auth_by(token:)
    user = find_by(token: token)
    raise AuthError unless user
    user
  end
end
