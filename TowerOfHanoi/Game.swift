//
//  Game.swift
//  TowerOfHanoi
//
//  Created by BARRY EZELL on 6/14/14.
//

import Foundation

class Game : Printable {
    var stackA, stackB, stackC: Stack
    let board: Array<Stack>
    let isEven: Bool
    var smallestDiskStackIndex: Int
    
    init(diskCount: Int) {
        stackA = Stack(diskCount: diskCount)
        stackB = Stack()
        stackC = Stack()
        
        board = [stackA, stackB, stackC]
        isEven = diskCount % 2 == 0
        smallestDiskStackIndex = 0
    }
    
    func ended() -> Bool {
        return !stackA.peek() && !stackB.peek()
    }
    
    func move(from: Stack, to: Stack) {
        if let disk = from.pop() {
            to.push(disk)
        }
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
    
    func solve() {
        var onSmallerMove = true
        
        while(!ended()) {
            println("move: \(onSmallerMove)")
            (onSmallerMove ? moveSmallestDisk() : moveLargerDisk())
            onSmallerMove = !onSmallerMove
        }
    }
    
    var description: String {
        return "A:\(stackA), B:\(stackB), C:\(stackC)"
    }
}
