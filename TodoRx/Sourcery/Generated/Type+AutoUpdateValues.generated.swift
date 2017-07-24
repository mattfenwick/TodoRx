// Generated using Sourcery 0.5.9 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

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

extension TodoItem {
	internal func updateValues(
			id: String? = nil,
			name: String? = nil,
			priority: TodoPriority? = nil,
			isFinished: Bool? = nil) -> TodoItem {
		return TodoItem(
			id: id ?? self.id,
			name: name ?? self.name,
			priority: priority ?? self.priority,
			isFinished: isFinished ?? self.isFinished)
	}
}

extension TodoModel {
	internal func updateValues(
			itemsDict: [String: TodoItem]? = nil) -> TodoModel {
		return TodoModel(
			itemsDict: itemsDict ?? self.itemsDict)
	}
}

