# frozen_string_literal: true
describe GeoTasks::Routing::Tasks do
  after(:each) do
    User.destroy_all
    Task.destroy_all
  end

  describe 'POST /tasks' do
    it 'works with correct params' do
      user = create(:user, role: 'Manager', token: 'manager_token')
      params = {
        pickup_location: [58.0, 38.0],
        delivery_location: [58.0, 38.0],
        token: user.token
      }
      post '/tasks', params.to_json
      expect(last_response).to be_ok
    end
  end
  describe 'POST /tasks/nearby'
  describe 'PUT /tasks/pick'
  describe 'PUT /tasks/complete'
end
