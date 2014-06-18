//
//  RecursiveGameTests.swift
//  TowerOfHanoi
//
//  Created by BARRY EZELL on 6/17/14.
//

import XCTest

class RecursiveGameTests: XCTestCase {
    func testSolveGame() {
        var game = RecursiveGame(diskCount: 3)
        game.solve()
        XCTAssert(game.💾.count == 7, "Should solve game with 3 disks in 7 moves")
    }
}
