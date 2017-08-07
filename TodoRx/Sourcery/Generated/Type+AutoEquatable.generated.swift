// Generated using Sourcery 0.5.9 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

// MARK: - AutoEquatable for structs, classes


// MARK: CreateTodoIntent Equatable
extension CreateTodoIntent: Equatable {
	internal static func ==(lhs: CreateTodoIntent, rhs: CreateTodoIntent) -> Bool {
		guard lhs.name == rhs.name else { return false }
		guard lhs.priority == rhs.priority else { return false }
		return true
	}
}

// MARK: CreateTodoViewModel Equatable
extension CreateTodoViewModel: Equatable {
	internal static func ==(lhs: CreateTodoViewModel, rhs: CreateTodoViewModel) -> Bool {
		guard lhs.todo == rhs.todo else { return false }
		return true
	}
}



// MARK: EditTodoIntent Equatable
extension EditTodoIntent: Equatable {
	internal static func ==(lhs: EditTodoIntent, rhs: EditTodoIntent) -> Bool {
		guard lhs.id == rhs.id else { return false }
		guard lhs.name == rhs.name else { return false }
		guard lhs.priority == rhs.priority else { return false }
		return true
	}
}

// MARK: EditTodoViewModel Equatable
extension EditTodoViewModel: Equatable {
	internal static func ==(lhs: EditTodoViewModel, rhs: EditTodoViewModel) -> Bool {
		guard lhs.id == rhs.id else { return false }
		guard lhs.initialName == rhs.initialName else { return false }
		guard lhs.initialPriority == rhs.initialPriority else { return false }
		guard lhs.name == rhs.name else { return false }
		guard lhs.priority == rhs.priority else { return false }
		return true
	}
}



// MARK: TodoItem Equatable
extension TodoItem: Equatable {
	internal static func ==(lhs: TodoItem, rhs: TodoItem) -> Bool {
		guard lhs.id == rhs.id else { return false }
		guard lhs.name == rhs.name else { return false }
		guard lhs.priority == rhs.priority else { return false }
		guard lhs.isFinished == rhs.isFinished else { return false }
		guard lhs.created == rhs.created else { return false }
		return true
	}
}


// MARK: TodoItemPersistenceResult Equatable
extension TodoItemPersistenceResult: Equatable {
	internal static func ==(lhs: TodoItemPersistenceResult, rhs: TodoItemPersistenceResult) -> Bool {
		guard lhs.itemId == rhs.itemId else { return false }
		guard lhs.action == rhs.action else { return false }
		guard lhs.success == rhs.success else { return false }
		return true
	}
}


// MARK: TodoListItem Equatable
extension TodoListItem: Equatable {
	internal static func ==(lhs: TodoListItem, rhs: TodoListItem) -> Bool {
		guard lhs.id == rhs.id else { return false }
		guard lhs.name == rhs.name else { return false }
		guard lhs.type == rhs.type else { return false }
		guard lhs.isFinished == rhs.isFinished else { return false }
		guard lhs.created == rhs.created else { return false }
		return true
	}
}

// MARK: TodoListSection Equatable
extension TodoListSection: Equatable {
	internal static func ==(lhs: TodoListSection, rhs: TodoListSection) -> Bool {
		guard lhs.sectionType == rhs.sectionType else { return false }
		guard lhs.rows == rhs.rows else { return false }
		return true
	}
}

// MARK: TodoListViewModel Equatable
extension TodoListViewModel: Equatable {
	internal static func ==(lhs: TodoListViewModel, rhs: TodoListViewModel) -> Bool {
		guard lhs.items == rhs.items else { return false }
		return true
	}
}

// MARK: TodoModel Equatable
extension TodoModel: Equatable {
	internal static func ==(lhs: TodoModel, rhs: TodoModel) -> Bool {
		guard lhs.itemsDict == rhs.itemsDict else { return false }
		guard lhs.state == rhs.state else { return false }
		return true
	}
}





// MARK: - AutoEquatable for Enums


// MARK: - CreateTodoAction AutoEquatable
extension CreateTodoAction: Equatable {
	internal static func ==(lhs: CreateTodoAction, rhs: CreateTodoAction) -> Bool {
		switch (lhs, rhs) {
			case let (.save(l0), .save(r0)): return l0 == r0
			case (.cancel, cancel): return true
			default: return false
		}
	}
}


// MARK: - CreateTodoCommand AutoEquatable
extension CreateTodoCommand: Equatable {
	internal static func ==(lhs: CreateTodoCommand, rhs: CreateTodoCommand) -> Bool {
		switch (lhs, rhs) {
			case (.initialState, initialState): return true
			case let (.updateName(l0), .updateName(r0)): return l0 == r0
			case let (.updatePriority(l0), .updatePriority(r0)): return l0 == r0
			case (.didTapSave, didTapSave): return true
			case (.didTapCancel, didTapCancel): return true
			default: return false
		}
	}
}


// MARK: - EditTodoAction AutoEquatable
extension EditTodoAction: Equatable {
	internal static func ==(lhs: EditTodoAction, rhs: EditTodoAction) -> Bool {
		switch (lhs, rhs) {
			case (.didTapCancel, didTapCancel): return true
			case let (.didTapSave(l0), .didTapSave(r0)): return l0 == r0
			default: return false
		}
	}
}


// MARK: - EditTodoCommand AutoEquatable
extension EditTodoCommand: Equatable {
	internal static func ==(lhs: EditTodoCommand, rhs: EditTodoCommand) -> Bool {
		switch (lhs, rhs) {
			case (.initialState, initialState): return true
			case let (.updateName(l0), .updateName(r0)): return l0 == r0
			case let (.updatePriority(l0), .updatePriority(r0)): return l0 == r0
			case (.didTapCancel, didTapCancel): return true
			case (.didTapSave, didTapSave): return true
			default: return false
		}
	}
}


// MARK: - TodoAction AutoEquatable
extension TodoAction: Equatable {
	internal static func ==(lhs: TodoAction, rhs: TodoAction) -> Bool {
		switch (lhs, rhs) {
			case (.fetchLocalTodos, fetchLocalTodos): return true
			case let (.saveTodo(l0), .saveTodo(r0)): return l0 == r0
			case let (.updateTodo(l0), .updateTodo(r0)): return l0 == r0
			case let (.deleteTodo(l0), .deleteTodo(r0)): return l0 == r0
			case (.showCreate, showCreate): return true
			case (.hideCreate, hideCreate): return true
			case let (.showEdit(l0), .showEdit(r0)): return l0 == r0
			case (.hideEdit, hideEdit): return true
			case (.duplicateIdError, duplicateIdError): return true
			case (.missingIdError, missingIdError): return true
			default: return false
		}
	}
}


// MARK: - TodoCommand AutoEquatable
extension TodoCommand: Equatable {
	internal static func ==(lhs: TodoCommand, rhs: TodoCommand) -> Bool {
		switch (lhs, rhs) {
			case (.initialState, initialState): return true
			case (.fetchSavedTodos, fetchSavedTodos): return true
			case let (.didFetchSavedTodos(l0), .didFetchSavedTodos(r0)): return l0 == r0
			case let (.didCompletePersistenceAction(l0), .didCompletePersistenceAction(r0)): return l0 == r0
			case (.showCreateView, showCreateView): return true
			case (.cancelCreate, cancelCreate): return true
			case let (.createNewItem(l0), .createNewItem(r0)): return l0 == r0
			case let (.showUpdateView(l0), .showUpdateView(r0)): return l0 == r0
			case (.cancelEdit, cancelEdit): return true
			case let (.updateItem(l0), .updateItem(r0)): return l0 == r0
			case let (.toggleItemIsFinished(l0), .toggleItemIsFinished(r0)): return l0 == r0
			case let (.deleteItem(l0), .deleteItem(r0)): return l0 == r0
			default: return false
		}
	}
}


// MARK: - TodoItemPersistenceAction AutoEquatable
extension TodoItemPersistenceAction: Equatable {
	internal static func ==(lhs: TodoItemPersistenceAction, rhs: TodoItemPersistenceAction) -> Bool {
		switch (lhs, rhs) {
			case (.save, save): return true
			case (.update, update): return true
			case (.delete, delete): return true
			default: return false
		}
	}
}


// MARK: - TodoListAction AutoEquatable
extension TodoListAction: Equatable {
	internal static func ==(lhs: TodoListAction, rhs: TodoListAction) -> Bool {
		switch (lhs, rhs) {
			case (.showCreate, showCreate): return true
			case let (.showEdit(l0), .showEdit(r0)): return l0 == r0
			case let (.toggleItemDone(l0), .toggleItemDone(r0)): return l0 == r0
			default: return false
		}
	}
}


// MARK: - TodoState AutoEquatable
extension TodoState: Equatable {
	internal static func ==(lhs: TodoState, rhs: TodoState) -> Bool {
		switch (lhs, rhs) {
			case (.todoList, todoList): return true
			case (.create, create): return true
			case (.edit, edit): return true
			default: return false
		}
	}
}
