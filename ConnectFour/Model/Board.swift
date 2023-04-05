//
//  Board.swift
//  ConnectFour
//
//  Created by Trevor Piltch on 3/28/23.
//

import Foundation

class Board: ObservableObject {
	@Published var items: [BoardItem] = []
	
	var columns: Int
	var rows: Int
	
	init(rows: Int, columns: Int) {
		self.rows = rows
		self.columns = columns
		
		for i in 0..<rows {
			for j in 0..<columns {
				let newItem = BoardItem(row: i, column: j, valid: i == (rows - 1))
				
				items.append(newItem)
			}
		}
	}
	
	/// Finds the valid spots in the given column
	func findValid(_ c: Int) {
		var filteredItems = self.items.filter { $0.column == c } // Only check the column that was just played
		
		filteredItems.sort { $0.row < $1.row }
		
		for index in 0..<(rows - 1) {
			let item = filteredItems[index] // Get the current item
			
			// Check if its the first row and empty
			if (index == rows - 1) && (item.owner == nil) {
				filteredItems[index].valid = true
				break
			}
			else if (index == rows - 1) {
				break
			}
			// Check if the previous row is not empty and the current row is
			else if (filteredItems[index + 1].owner != nil) && (item.owner == nil) {
				filteredItems[index].valid = true
				break
			}
		}
	}
	
	/// Combines the horizontal, vertical, and diagonal win checks
	func checkWin() -> Player? {
		let playerH = checkWinHorizontal()
		let playerV = checkWinVertical()
		let playerDA = checkWinDiagonalAscending()
		let playerDD = checkWinDiagonalDescending()
		
		if let playerDA {
			print("Ascending win.")
			return playerDA
		}
		
		if let playerH {
			print("Horizontal win.")
			return playerH
		}
		
		if let playerV {
			print("Vertical win.")
			return playerV
		}
		
		if let playerDD {
			print("Descending win.")
			return playerDD
		}
		
		return nil
	}
	
	// MARK: Helper methods
	/// Checks each row for 4 of the same owners in a column
	private func checkWinVertical() -> Player? {
		for r in 0..<(self.rows - 3) {
			for c in 0..<self.columns {
				let itemsInColumn = items.filter { $0.column == c }
				let firstItem = itemsInColumn.first { $0.row == r }!
				let secondItem = itemsInColumn.first { $0.row == r + 1 }!
				let thirdItem = itemsInColumn.first { $0.row == r + 2 }!
				let fourthItem = itemsInColumn.first { $0.row == r + 3 }!
			
				let hasWon = (firstItem.owner == secondItem.owner) && (thirdItem.owner == fourthItem.owner) && (firstItem.owner == thirdItem.owner) && (firstItem.owner != nil)
				
				if hasWon {
					return firstItem.owner
				}
			}
		}
		
		return nil
	}
	
	/// Checks each column for 4 of the same owners in a row
	private func checkWinHorizontal() -> Player? {
		for c in 0..<(self.columns - 3) {
			for r in 0..<self.rows {
				let itemsInRow = items.filter { $0.row == r }
				let firstItem = itemsInRow.first { $0.column == c }!
				let secondItem = itemsInRow.first { $0.column == c + 1 }!
				let thirdItem = itemsInRow.first { $0.column == c + 2 }!
				let fourthItem = itemsInRow.first { $0.column == c + 3 }!
			
				let hasWon = (firstItem.owner == secondItem.owner) && (thirdItem.owner == fourthItem.owner) && (firstItem.owner == thirdItem.owner) && (firstItem.owner != nil)
				
				if hasWon {
					return firstItem.owner
				}
			}
		}
		
		return nil
	}
	
	private func checkWinDiagonalDescending() -> Player? {
		for r in 3..<self.rows {
			for c in 3..<(self.columns) {
				let firstItem = items.first { $0.column == c && $0.row == r }!
				let secondItem = items.first { $0.column == c - 1 && $0.row == (r - 1) }!
				let thirdItem = items.first { $0.column == c - 2 && $0.row == (r-2) }!
				let fourthItem = items.first { $0.column == c - 3 && $0.row == (r-3) }!
			
				let hasWon = (firstItem.owner == secondItem.owner) && (thirdItem.owner == fourthItem.owner) && (firstItem.owner == thirdItem.owner) && (firstItem.owner != nil)
				
				if hasWon {
					return firstItem.owner
				}
			}
		}
		
		return nil
	}
	
	/// Checks the win condition for all ascending items
	private func checkWinDiagonalAscending() -> Player? {
		for r in 3..<self.rows {
			for c in 0..<(self.columns-3) {
				let firstItem = items.first { $0.column == c && $0.row == r }!
				let secondItem = items.first { $0.column == c + 1 && $0.row == (r - 1) }!
				let thirdItem = items.first { $0.column == c + 2 && $0.row == (r-2) }!
				let fourthItem = items.first { $0.column == c + 3 && $0.row == (r-3) }!
			
				let hasWon = (firstItem.owner == secondItem.owner) && (thirdItem.owner == fourthItem.owner) && (firstItem.owner == thirdItem.owner) && (firstItem.owner != nil)
				
				if hasWon {
					return firstItem.owner
				}
			}
		}
		
		return nil
	}
	
	/// Writes the board state to the output
	func describe(_ c: Int) {
		print("\(columns) Columns; \(rows) Rows")
		print("Items: \n")
		for item in items where item.column == c {
			print("(column, row) (\(item.column), \(item.row))")
			print("Valid: \(item.valid)")
			print("Owner: \(item.owner?.icon ?? "Empty")\n")
		}
	}
}
