# frozen_string_literal: true
describe User do
  after(:each) do
    User.destroy_all
    Task.destroy_all
  end

  describe '.auth_by(token:)' do
    context 'with correct token' do
      it 'finds user' do
        correct_token = 'correct_token'
        user = create(:user, token: correct_token)

        founded_user = User.auth_by(token: correct_token)

        expect(founded_user).to eq user
      end
    end
    context 'with incorrect token' do
      it 'rises AuthError' do
        incorrect_token = 'incorrect_token'
        create(:user, token: 'correct_token')

        expect { User.auth_by(token: incorrect_token) }
          .to raise_error(AuthError)
      end
    end
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

  describe '#create_task' do
    context 'for Manager role' do
      it 'creates new task' do
        user = create(:user, role: 'Manager')

        expect do
          user.create_task(pickup_location: [7, 5], delivery_location: [5, 1])
        end.to change { Task.count }.from(0).to(1)
      end
    end
    context 'for non Manager role' do
      it 'raises PermissionDenied' do
        user = create(:user, role: 'Driver')

        expect do
          user.create_task(pickup_location: [7, 5], delivery_location: [5, 1])
        end.to raise_error(PermissionDenied)
      end
    end
  end

  describe '#complete_task' do
    it 'marks task as Done' do
      user = create(:user, role: 'Driver')
      task = create(:task)
      user.assign_task(task_id: task.id)

      user.complete_task

      task.reload
      expect(task.status).to eq 'Done'
    end
    it 'allows Driver to pick a new task' do
      user = create(:user, role: 'Driver')
      task = create(:task)
      another_task = create(:task)
      user.assign_task(task_id: task.id)

      user.complete_task
      user.assign_task(task_id: another_task.id)

      user.reload
      expect(user.assigned_task).to eq another_task.id.to_s
    end
    it 'raises NoActiveTasks error if there is no task assigned to driver' do
      user = create(:user, role: 'Driver')

      expect { user.complete_task }.to raise_error(NoActiveTasks)
    end
  end
end
