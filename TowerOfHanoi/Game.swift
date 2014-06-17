//
//  Game.swift
//  TowerOfHanoi
//
//  Created by BARRY EZELL on 6/14/14.
//

import Foundation

// Add stack functions to Array
extension Array {
    mutating func push(item: T) {
        append(item)
    }
    
    mutating func pop() -> T? {
        return (count > 0 ? removeLast() : nil)
    }
    
    func peek() -> T? {
        return (count > 0 ? self[count-1] : nil)
    }
}

struct SortedStacks {
    var smallestDiskStack: Array<Int>
    var otherStacks: Array<Array<Int>>
}

class Game {
    var stackA, stackB, stackC: Array<Int>
    let isEven: Bool
    var smallestDiskStackIndex: Int
    
    // Note: board must be a computed (dynamic) property
    // because arrays are pass-by-value. Otherwise, board
    // would not reflect the current state of any member arrays
    // after initialization.
    var board: Array<Array<Int>> {
        get {
            return [stackA, stackB, stackC]
        }
    }
    
    init(diskCount: Int) {
        stackA = []
        stackB = []
        stackC = []
        
        // Add disks to stackA.
        // Note: range enumeration in Swift only increments
        for i in (0..diskCount) {
            stackA.push(diskCount - i)
        }
        
        isEven = diskCount % 2 == 0
        smallestDiskStackIndex = 0
    }
    
    func ended() -> Bool {
        return !stackA.peek() && !stackB.peek()
    }
    
    func move(inout from: Array<Int>, inout to: Array<Int>) {
        if let disk = from.pop() {
            to.push(disk)
        }
    }
    
    func sortStacks() -> SortedStacks {
        var smallestDiskStack = board[smallestDiskStackIndex]
        var otherStacks = board.filter{ $0 != smallestDiskStack }
        return SortedStacks(smallestDiskStack: smallestDiskStack, otherStacks: otherStacks)
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