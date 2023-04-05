//
//  ConnectFourApp.swift
//  ConnectFour
//
//  Created by Trevor Piltch on 3/27/23.
//

import SwiftUI

@main
struct ConnectFourApp: App {
	@StateObject private var board = Board(rows: 7, columns: 6)
	@State private var gameSetup = false
	@State private var players = [
		Player(icon: "😁", isBot: false),
		Player(icon: "🔺", isBot: false)
	]
	
    var body: some Scene {
        WindowGroup("Connect Four") {
			if !gameSetup {
				GameSetupView(board: board, gameSetup: $gameSetup, players: $players)
					.frame(minWidth: 300, minHeight: 300)
			}
			else {
				ContentView(board: board, players: $players, gameSetup: $gameSetup)
					.frame(minWidth: 300, minHeight: 300)
			}
        }
    }
}
