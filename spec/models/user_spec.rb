# frozen_string_literal: true
describe User do
  after(:each) do
    User.destroy_all
    Task.destroy_all
  end

  describe '#assign_task' do
    context 'for Driver role' do
      it 'marks task as Assigned' do
        user = create(:user, role: 'Driver')
        task = create(:task, status: 'New')

        user.assign_task(task_id: task.id)
        task.reload

        expect(task.status).to eq 'Assigned'
      end

      it 'saves task_id to driver' do
        user = create(:user, role: 'Driver')
        task = create(:task, status: 'New')

        user.assign_task(task_id: task.id)
        user.reload

        expect(user.assigned_task).to eq task.id.to_s
      end
    end
    context 'for non Driver role' do
      it 'raises PermissionDenied' do
        user = create(:user, role: 'Manager')
        task = create(:task, status: 'New')

        expect { user.assign_task(task_id: task.id) }
          .to raise_error(PermissionDenied)
      end
    end
    it 'cannot assign already assigned task' do
      user = create(:user, role: 'Driver')
      task = create(:task, status: 'Assigned')

      expect { user.assign_task(task_id: task.id) }
        .to raise_error(AlreadyAssigned)
    end
    it 'raises HaveNotCompletedTask if driver already have a task' do
      user = create(:user, role: 'Driver')
      task = create(:task, status: 'New')
      user.assign_task(task_id: task.id)
      another_task = create(:task, status: 'New')

      expect { user.assign_task(task_id: another_task.id) }
        .to raise_error(HaveNotCompletedTask)
    end
  end
end
