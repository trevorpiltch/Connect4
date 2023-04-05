//
//  ViewMethods.swift
//  ConnectFour
//
//  Created by Trevor Piltch on 4/4/23.
//

import Foundation

/// Helper methods for the view
extension ContentView {
	/// Runs a game where both players are bots until a winner is determined
	func runBotGame() {
		var player: Player?
		
		while player == nil {
			let item = board.items[0]
			
			player = players[0].place($board.items[0], board: board, r: item.row, c: item.column)
			
			currentPlayer = (currentPlayer + 1) % 2
			
			if player != nil {
				break
			}
			else {
				player = players[1].place($board.items[0], board: board, r: item.row, c: item.column)
				currentPlayer = (currentPlayer + 1) % 2
			}
		}
		
		title = "Congrats \(player!.icon), you won!"
		gameOver = true
		
	}
	
	/// Resets the all the items, the current player, and title
	func resetBoard() {
		for item in $board.items {
			item.owner.wrappedValue = nil
			
			if item.row.wrappedValue == board.rows - 1 {
				item.valid.wrappedValue = true
			}
			else {
				item.valid.wrappedValue = false
			}
		}
		
		self.currentPlayer = 0
		self.gameOver = false
		self.title = players[currentPlayer].label()
		self.message = ""
	}
	
	func didPlayerWin(_ player: Player?) {
		if let player {
			title = "Congrats \(player.icon), you won!"
			gameOver = true
		}
	}
}
