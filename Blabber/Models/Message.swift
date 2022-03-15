//
//  Message.swift
//  Blabber
//
//  Created by DispatchSwift on 3/14/22.
//

import Foundation

struct Message: Codable, Identifiable, Hashable {
	let id: UUID
	let user: String?
	let message: String
	var date: Date
}

extension Message {
	init(message: String) {
		self.id = .init()
		self.user = nil
		self.message = message
		self.date = .init()
	}
}
