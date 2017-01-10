# frozen_string_literal: true
class User
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String
  field :role, type: String
  field :token, type: String
  field :assigned_task, type: String

  index({ token: 1 }, unique: true)

  def self.auth_by(token:)
    find_by(token: token)
  rescue Mongoid::Errors::DocumentNotFound
    raise AuthError
  end

  def assign_task(task_id:)
    raise PermissionDenied unless role == 'Driver'
    raise HaveNotCompletedTask if assigned_task
    # Make sure only one driver can pick a task, it's atomic operation
    task = Task.where(_id: task_id, status: 'New')
               .find_one_and_update(
                 '$set': { status: 'Assigned', assigned_driver: id }
               )
    raise AlreadyAssigned unless task
    self.assigned_task = task.id
    save
  end
end
