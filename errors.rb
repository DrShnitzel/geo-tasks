# frozen_string_literal: true
AuthError = Class.new(StandardError)
PermissionDenied = Class.new(StandardError)
HaveNotCompletedTask = Class.new(StandardError)
AlreadyAssigned = Class.new(StandardError)
NoActiveTasks = Class.new(StandardError)
