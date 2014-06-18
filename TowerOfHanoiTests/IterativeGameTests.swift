//
//  IterativeGameTests.swift
//  TowerOfHanoi
//
//  Created by BARRY EZELL on 6/14/14.
//

import XCTest

class IterativeGameTests: XCTestCase {
    func testIterativeGameHasEnded() {
        var game = IterativeGame(diskCount: 3)
        XCTAssert(game.ended() == false, "New game should not be ended")
        game.stackA = Stack()
        XCTAssert(game.ended() == true, "IterativeGame has ended when stack A and B have no more disks")
    }
    
    func testMoveDiskBetweenStacks() {
        var game = IterativeGame(diskCount: 3)
        game.move(game.stackA, to: game.stackC)
        XCTAssert(game.stackC.peek() == 1, "Can move a disk between stacks")
    }

    // Note: implementing iterative solution from http://en.wikipedia.org/wiki/Tower_of_Hanoi
    func testMoveSmallestDiskStackWhenOdd() {
        var game = IterativeGame(diskCount: 3)
        game.moveSmallestDisk()
        XCTAssert(game.stackC.peek() == 1, "Smallest piece should move to far stack on first move when odd")
        game.moveSmallestDisk()
        XCTAssert(game.stackB.peek() == 1, "Smallest piece should move left when odd")
    }
    
    func testMoveSmallestDiskStackWhenEven() {
        var game = IterativeGame(diskCount: 4)
        game.moveSmallestDisk()
        XCTAssert(game.stackB.peek() == 1, "Smallest piece should move right when even")
        game.moveSmallestDisk()
        game.moveSmallestDisk()
        XCTAssert(game.stackA.peek() == 1, "Smallest piece should move right when even")
    }
    
    func testMoveLargerDisk() {
        var game = IterativeGame(diskCount: 3)
        game.moveSmallestDisk()
        game.moveLargerDisk()
        XCTAssert(game.stackB.peek() == 2, "Larger piece should move to empty peg")
        
        game.moveSmallestDisk()
        game.moveLargerDisk()
        XCTAssert(game.stackA.peek() == nil, "A should be empty after 2nd large move")
        XCTAssert(game.stackC.peek() == 3, "C should have largest piece after 2nd large move")
    }
    
    func testSolveGame() {
        var game = IterativeGame(diskCount: 3)
        game.solve()
        XCTAssert(game.log.count == 7, "Should solve game with 3 disks in 7 moves")
    }
}
