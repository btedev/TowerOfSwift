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
        game.move(&game.stackA, to: &game.stackC)
        XCTAssert(game.stackC.peek() == 1, "Can move a disk between stacks")
    }
    
    func testSortingStacksByDiskSize() {
        var game = Game(diskCount: 3)
        game.stackA.pop()
        game.stackC.push(1)
        game.smallestDiskStackIndex = 2
        let sortedStacks = game.sortStacks()
        XCTAssert(sortedStacks.smallestDiskStack == game.stackC, "Should sort opening game state stacks (smallest)")
        XCTAssert(sortedStacks.otherStacks == [game.stackA, game.stackB], "Should sort opening game state stacks (other)")
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
    
    /*
    func testFindNonSmallStacks() {
        var game = Game(diskCount: 3)
        var testArr: Array = game.nonSmallStacks()
        var targetArr: Array = [game.stackB, game.stackC]
        XCTAssert(testArr == targetArr, "Find the two stacks that don't contain the smallest disk")
    }
*/
}
