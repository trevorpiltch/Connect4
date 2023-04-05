//
//  Player.swift
//  ConnectFour
//
//  Created by Trevor Piltch on 3/28/23.
//

import Foundation
import SwiftUI

struct Player: Identifiable, Equatable {	
	var icon: String
	var isBot = false
	let id = UUID()
	
	/// Places the player in the item , finds the new valid spots, and switches player
	func place(_ item: Binding<BoardItem>?, board: Board, r: Int?, c: Int?) -> Player? {
		if isBot {
			let column = botPlace(board: board)
			board.findValid(column)
		}
		else {
			playerPlace(item!, r: r!, c: c!)
			board.findValid(c!)
		}
		
		return board.checkWin()
	}
	
	/// Helper method for the title of the view
	func label() -> String {
		return "\(icon)'s Turn"
	}
}

/// Player methods
extension Player {
	/// Places the player piece in the specified spot
	private func playerPlace(_ item: Binding<BoardItem>, r: Int, c: Int) {
		withAnimation {
			item.owner.wrappedValue = self
			item.valid.wrappedValue = false
		}
	}
}

/// Bot Methods
extension Player {
	/// Generates a random column to place the bot in
	private func botPlace(board: Board, random: Int? = nil) -> Int  {
		let columns = board.columns
		var randomColumn = random
			
		if random == nil {
			randomColumn = Int.random(in: 0..<(columns))
		}
		
		var hasValids = false
		
		for item in board.items where item.column == randomColumn  {
			if (item.owner == nil) && (item.valid) {
				hasValids = true
				item.owner = self
				item.valid = false
			}
		}
		
		// Reruns the bot algorithm until a valid spot is found
		if !hasValids {
			return botPlace(board: board, random: random)
		}
		
		return randomColumn!
	}
}
