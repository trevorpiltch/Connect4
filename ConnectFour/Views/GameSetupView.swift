//
//  GameSetupView.swift
//  ConnectFour
//
//  Created by Trevor Piltch on 4/4/23.
//

import SwiftUI

struct GameSetupView: View {
	@ObservedObject var board: Board
	
	@Binding var gameSetup: Bool
	@Binding var players: [Player]
	
    var body: some View {
		NavigationStack {
			VStack {
				Text("😁 Welcome to Connect Four 🔺")
					.font(.largeTitle)
				
				Text("🤖Select the number of bots. Both players as bots will let you simulate many games in a short time!")
					.multilineTextAlignment(.center)
					.padding(.top, 8)
				
				Text("💻 To play, just click on a cell to place your piece.")
					.multilineTextAlignment(.center)
					.padding(.top, 2)
				
				Spacer()
				
				ForEach($players) { $player in
					HStack {
						Text("\(player.icon)")
						
						Toggle(isOn: $player.isBot) {
							Text("Bot")
						}
					}
				}
				
				Spacer()
				
				Button {
					gameSetup = true
				} label: {
					Text("Begin Game!")
				}
				.padding(.bottom)
			}
		}
    }
}

struct GameSetupView_Previews: PreviewProvider {

	
    static var previews: some View {
		@State var players = [Player(icon: "😁", isBot: false), Player(icon: "🔺", isBot: false)]
		
		GameSetupView(board: Board(rows: 3, columns: 3), gameSetup: .constant(false), players: $players)
    }
}
