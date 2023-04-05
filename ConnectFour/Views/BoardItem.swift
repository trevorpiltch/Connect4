//
//  BoardItem.swift
//  ConnectFour
//
//  Created by Trevor Piltch on 3/28/23.
//

import Foundation
import SwiftUI

class BoardItem: ObservableObject, Identifiable {
	@Published var owner: Player?
	@Published var valid: Bool
	
	var row: Int
	var column: Int
	let id = UUID()
	
	init(row: Int, column: Int, valid: Bool) {
		self.row = row
		self.column = column
		self.valid = valid
	}
}
