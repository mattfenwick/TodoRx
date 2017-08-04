// Generated using Sourcery 0.5.9 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation


extension TodoItem {
	internal init(
			id: String,
			name: String,
			priority: TodoPriority,
			isFinished: Bool,
			created: Date) {
		self.id = id
		self.name = name
		self.priority = priority
		self.isFinished = isFinished
		self.created = created
	}
}


