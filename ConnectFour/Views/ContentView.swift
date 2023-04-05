//
//  ContentView.swift
//  ConnectFour
//
//  Created by Trevor Piltch on 3/27/23.
//

import SwiftUI

struct ContentView: View {
	@Environment(\.openURL) private var openURL
	
	@ObservedObject var board: Board
	
	@Binding var players: [Player]
	@Binding var gameSetup: Bool
	
	@State var showHelp = false
	@State var currentPlayer = 0
	@State var message = ""
	@State var gameOver = false
	@State var title = ""
	
    var body: some View {
        NavigationStack {
			VStack {
				Text(title)
					.font(.largeTitle)
				
				Text(message)
					.foregroundColor(.red)
					.font(.subheadline)
				
				Spacer()
				
				Grid {
					Rectangle()
						.frame(height: 2)
					
					ForEach(0..<board.rows) { index in
						GridRow {
							Rectangle()
								.frame(width: 2)
							
							ForEach($board.items.filter({$0.wrappedValue.row == index})) { $item in
								Button {
									if item.valid && item.owner == nil && !gameOver {
										message = ""
										
										var player = players[currentPlayer].place($item, board: board, r: item.row, c: item.column)
										
										didPlayerWin(player)
										
										currentPlayer = (currentPlayer + 1) % 2
										
										if players[currentPlayer].isBot && !gameOver {
											player = players[currentPlayer].place($item, board: board, r: item.row, c: item.column)

											didPlayerWin(player)

											currentPlayer = (currentPlayer + 1) % 2
										}
										
										if !gameOver {
											title = "\(players[currentPlayer].icon)'s Turn"
										}
									}
									else {
										message = "Please select a valid spot"
									}
								} label: {
									Text(item.owner?.icon ?? "     ")
										.scaleEffect(x: item.owner == nil ? 0.0001 : 1, y: item.owner == nil ? 0.0001 : 1)
								}
								.buttonStyle(.borderless)
								.font(.headline)
								
								Rectangle()
									.frame(width: 2)
							}
						}
						
						Rectangle()
							.frame(height: 2)
					}
				}
			}
			.toolbar {
				Button {
					resetBoard()
					
					if players[0].isBot && players[1].isBot {
						runBotGame()
					}
					else if players[0].isBot {
						title = players[currentPlayer].label()
						let _ = players[currentPlayer].place(nil, board: board, r: nil, c: nil)
						currentPlayer = (currentPlayer + 1) % 2
					}
				} label: {
					Text("Reset")
						.foregroundColor(.red)
				}
				
				Button {
					resetBoard()
					gameSetup = false
				} label: {
					Text("Game Setup")
						.foregroundColor(.blue)
				}
				
				Button {
					self.showHelp = true
				} label: {
					Image(systemName: "questionmark.circle.fill")
				}
			}
			
			Spacer()
        }
		.overlay {
			// Only run confetti if its not a bot vs. bot game
			if gameOver && !(players[0].isBot && players[1].isBot) {
				Circle()
					.fill(Color.blue)
					.frame(width: 20, height: 20)
					.modifier(ConfettiEffect())
			}
		}
		.padding()
		.frame(maxWidth: 400, maxHeight: 400)
		.alert(isPresented: $showHelp) {
			Alert(
				title: Text("Help"),
				message: Text("Want to read more on WikiHow?"),
				primaryButton: .destructive(Text("No")),
				secondaryButton: .default(
					Text("Yes"), action: {
					openURL(URL(string: "https://www.wikihow.com/Play-Connect-4")!)
				}
				)
			)
		}
		.onAppear {
			title = players[currentPlayer].label()
			
			if players[0].isBot && players[1].isBot {
				runBotGame()
			}
			else if players[0].isBot {
				let _ = players[currentPlayer].place(nil, board: board, r: nil, c: nil)
				currentPlayer = (currentPlayer + 1) % 2
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView(board: Board(rows: 6, columns: 7), players: .constant([]), gameSetup: .constant(true))
    }
}
