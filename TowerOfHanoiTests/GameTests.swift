//
//  GameTests.swift
//  TowerOfHanoi
//
//  Created by BARRY EZELL on 6/14/14.
//  Copyright (c) 2014 Dockmarket LLC. All rights reserved.
//

import XCTest

class GameTests: XCTestCase {
    func testGameHasEnded() {
        var game = Game(diskCount: 3)
        XCTAssert(game.ended() == false, "New game should not be ended")
        game.stackA = Stack()
        XCTAssert(game.ended() == true, "Game has ended when stack A and B have no more disks")
    }
    
    func testMoveDiskBetweenStacks() {
        var game = Game(diskCount: 3)
        game.move(game.stackA, to: game.stackC)
        XCTAssert(game.stackC.peek() == 1, "Can move a disk between stacks")
    }

    // Note: implementing iterative solution from http://en.wikipedia.org/wiki/Tower_of_Hanoi
    func testMoveSmallestDiskStackWhenOdd() {
        var game = Game(diskCount: 3)
        game.moveSmallestDisk()
        XCTAssert(game.stackC.peek() == 1, "Smallest piece should move to far stack on first move when odd")
        game.moveSmallestDisk()
        XCTAssert(game.stackB.peek() == 1, "Smallest piece should move left when odd")
    }
    
    func testMoveSmallestDiskStackWhenEven() {
        var game = Game(diskCount: 4)
        game.moveSmallestDisk()
        XCTAssert(game.stackB.peek() == 1, "Smallest piece should move right when even")
        game.moveSmallestDisk()
        game.moveSmallestDisk()
        XCTAssert(game.stackA.peek() == 1, "Smallest piece should move right when even")
    }
    
    func testMoveLargerDisk() {
        var game = Game(diskCount: 3)
        game.moveSmallestDisk()
        game.moveLargerDisk()
        XCTAssert(game.stackB.peek() == 2, "Larger piece should move to empty peg")
        
        game.moveSmallestDisk()
        game.moveLargerDisk()
        //println("2nd large move A = \(game.stackA.disks)")
        //println("2nd large move B = \(game.stackB.disks)")
        //println("2nd large move C = \(game.stackC.disks)")
        XCTAssert(game.stackA.peek() == nil, "A should be empty after 2nd large move")
        XCTAssert(game.stackC.peek() == 3, "C should have largest piece after 2nd large move")
    }
    
    func testSolveGame() {
        var game = Game(diskCount: 3)
        game.solve()
        XCTAssert(game.ended(), "Should solve game with 3 disks")
    }
}
