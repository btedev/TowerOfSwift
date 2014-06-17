//
//  Game.swift
//  TowerOfHanoi
//
//  Created by BARRY EZELL on 6/14/14.
//

import Foundation

struct SortedStacks {
    var smallestDiskStack: Stack
    var otherStacks: Array<Stack>
}

class Game {
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
    
    func move(inout from: Stack, inout to: Stack) {
        if let disk = from.pop() {
            to.push(disk)
        }
    }
    
    func sortStacks() -> SortedStacks {
        var boardCopy = board.copy()
        var smallestDiskStack = boardCopy[smallestDiskStackIndex]
        boardCopy.removeAtIndex(smallestDiskStackIndex)
        return SortedStacks(smallestDiskStack: smallestDiskStack, otherStacks: boardCopy)
    }
    
    func moveSmallestDisk() {
        let moveDirection = (isEven ? 1 : -1)
        var moveToIndex = smallestDiskStackIndex + moveDirection
        
        if moveToIndex ==  -1 {
            moveToIndex = 2
        } else if moveToIndex == 3 {
            moveToIndex = 0
        }
        
        move(&board[smallestDiskStackIndex], to: &board[moveToIndex])
        smallestDiskStackIndex = moveToIndex
    }
    
    /*
    func moveLargerDisk() {
        
    }
    
    func nonSmallStacks() -> Array<Stack> {
        var stacks = Array<Stack>()
        for (idx, val) in enumerate(board) {
            if idx != smallestDiskIndex {
                stacks += val
            }
        }
        return stacks
    }
*/
}