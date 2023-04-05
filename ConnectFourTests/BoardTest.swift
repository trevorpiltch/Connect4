//
//  BoardTest.swift
//  ConnectFour
//
//  Created by Trevor Piltch on 4/4/23.
//

import XCTest
import SwiftUI

final class BoardTest: XCTestCase {
	let board = Board(rows: 6, columns: 7)
	var view: ContentView?
	
	@State var players = [Player(icon: "😢", isBot: true), Player(icon: "🫥", isBot: true)]

    override func setUpWithError() throws {
		
		view = ContentView(board: board, players: $players, gameSetup: .constant(true))

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
		for _ in 0..<100 {
			
			view!.runBotGame()
			
			print(view!.title)
		}
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
