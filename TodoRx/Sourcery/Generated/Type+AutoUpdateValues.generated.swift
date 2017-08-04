// Generated using Sourcery 0.5.9 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation


extension CreateTodoIntent {
	internal func updateValues(
			name: String? = nil,
			priority: TodoPriority? = nil) -> CreateTodoIntent {
		return CreateTodoIntent(
			name: name ?? self.name,
			priority: priority ?? self.priority)
	}
}

extension CreateTodoViewModel {
	internal func updateValues(
			todo: CreateTodoIntent? = nil) -> CreateTodoViewModel {
		return CreateTodoViewModel(
			todo: todo ?? self.todo)
	}
}

extension EditTodoViewModel {
	internal func updateValues(
			id: String? = nil,
			initialName: String? = nil,
			initialPriority: TodoPriority? = nil,
			name: String? = nil,
			priority: TodoPriority? = nil) -> EditTodoViewModel {
		return EditTodoViewModel(
			id: id ?? self.id,
			initialName: initialName ?? self.initialName,
			initialPriority: initialPriority ?? self.initialPriority,
			name: name ?? self.name,
			priority: priority ?? self.priority)
	}
}

extension TodoItem {
	internal func updateValues(
			id: String? = nil,
			name: String? = nil,
			priority: TodoPriority? = nil,
			isFinished: Bool? = nil,
			created: Date? = nil) -> TodoItem {
		return TodoItem(
			id: id ?? self.id,
			name: name ?? self.name,
			priority: priority ?? self.priority,
			isFinished: isFinished ?? self.isFinished,
			created: created ?? self.created)
	}
}

extension TodoModel {
	internal func updateValues(
			itemsDict: [String: TodoItem]? = nil) -> TodoModel {
		return TodoModel(
			itemsDict: itemsDict ?? self.itemsDict)
	}
}

