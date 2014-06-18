//
//  Game.swift
//  TowerOfHanoi
//
//  Created by BARRY EZELL on 6/14/14.
//

import Foundation

class Game {
    var stackA, stackB, stackC: Stack
    let board: Array<Stack>
    var log = Array<String>()
    
    init(diskCount: Int) {
        stackA = Stack(diskCount: diskCount)
        stackB = Stack()
        stackC = Stack()
        board = [stackA, stackB, stackC]
    }
    
    func ended() -> Bool {
        return !stackA.peek() && !stackB.peek()
    }
    
    func move(from: Stack, to: Stack) {
        if let disk = from.pop() {
            to.push(disk)
            logState()
        }
    }
    
    func logState() {
        log += "A:\(stackA)|B:\(stackB)|C:\(stackC)"
    }
    
    func solve() {
    }
}

class IterativeGame : Game {
    let isEven: Bool
    var smallestDiskStackIndex: Int
    
    init(diskCount: Int) {
        isEven = diskCount % 2 == 0
        smallestDiskStackIndex = 0
        super.init(diskCount: diskCount)
    }
    
    func moveSmallestDisk() {
        let moveDirection = (isEven ? 1 : -1)
        var moveToIndex = smallestDiskStackIndex + moveDirection
        
        if moveToIndex ==  -1 {
            moveToIndex = 2
        } else if moveToIndex == 3 {
            moveToIndex = 0
        }
        
        move(board[smallestDiskStackIndex], to: board[moveToIndex])
        smallestDiskStackIndex = moveToIndex
    }
    
    func moveLargerDisk() {
        var otherStackIndexes: Int[] = [0,1,2]
        otherStackIndexes.removeAtIndex(smallestDiskStackIndex)
        let otherStacks = (board[otherStackIndexes[0]], board[otherStackIndexes[1]])
        
        switch otherStacks {
        case let (a, b) where a.peek() == nil:
            move(b, to: a)
        case let (a, b) where b.peek() == nil:
            move (a, to: b)
        case let (a, b) where a.peek() < b.peek():
            move (a, to: b)
        case let (a, b) where a.peek() > b.peek():
            move(b, to: a)
        default:
            println("Unexpected case in moveLargerDisk()")
        }
    }
    
    override func solve() {
        var onSmallerMove = true
        
        while(!ended()) {
            (onSmallerMove ? moveSmallestDisk() : moveLargerDisk())
            onSmallerMove = !onSmallerMove
        }
    }
}

class RecursiveGame: Game {
    var diskCount: Int
    
    init(diskCount: Int) {
        self.diskCount = diskCount
        super.init(diskCount: diskCount)
    }
    
    override func solve() {
        move(diskCount, from: stackA, to: stackC, pivot: stackB)
    }
    
    func move(n: Int, from: Stack, to: Stack, pivot: Stack) {
        if n > 1 { move(n-1, from: from, to: pivot, pivot: to) }
        super.move(from, to: to)
        if n > 1 { move(n-1, from: pivot, to: to, pivot: from) }
    }
}
