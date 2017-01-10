describe Task do
  after(:each) do
    Task.destroy_all
  end

  describe '.tasks_nearby' do
    context 'when nearby tasks exist' do
      it 'returns list of tasks ordered by distance' do
        location = [38.8, 58.0]
        task = create(:task, pickup_location: [38.8, 58.03])
        furtherest_task = create(:task, pickup_location: [38.82, 58.05])
        closest_task = create(:task, pickup_location: [38.8, 58.01])

        resp = Task.tasks_nearby(location)
        expectation = [closest_task, task, furtherest_task]

        expect(resp).to eq expectation
      end
      it 'does not return tasks located too far' do
        location = [38.8, 58.0]
        create(:task, pickup_location: [38.8, 58.03])
        task_to_far = create(:task, pickup_location: [40.0, 60.05])

        resp = Task.tasks_nearby(location)

        expect(resp.include?(task_to_far)).to be false
      end
    end
    context 'when there are no nearby tasks' do
      it 'returns empty array' do
        expect(Task.tasks_nearby([38.8, 58.0])).to eq []
      end
    end
  end
end
