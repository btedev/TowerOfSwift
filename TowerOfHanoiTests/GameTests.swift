//
//  GameTests.swift
//  TowerOfHanoi
//
//  Created by BARRY EZELL on 6/14/14.
//  Copyright (c) 2014 Dockmarket LLC. All rights reserved.
//

import XCTest

class GameTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGameHasEnded() {
        var game = Game(diskCount: 4)
        XCTAssert(game.ended() == false, "New game should not have ended")
        game.stacks[Peg.A] = Stack()
        game.stacks[Peg.B] = Stack()
        game.stacks[Peg.C] = Stack(diskCount: 4)
        XCTAssert(game.ended() == true, "Game has ended when all disks are on Peg C")
    }
}
