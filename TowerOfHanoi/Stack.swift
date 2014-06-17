//
//  Stack.swift
//  TowerOfHanoi
//
//  Created by BARRY EZELL on 6/17/14.
//

import Foundation

class Stack: Equatable, Printable {
    var disks = Array<Int>()
    
    init(var diskCount: Int = 0) {
        // Note: range enumeration in Swift only increments
        // so diskCount..0 doesn't work.
        for i in 0..diskCount {
            push(diskCount-i)
        }
    }
    
    func push(disk: Int) {
        if let topDisk = peek() {
            assert(disk < topDisk, "A larger disk may not be placed on a smaller disk")
        }
        
        disks += disk
    }
    
    func pop() -> Int? {
        return (disks.count > 0 ? disks.removeLast() : nil)
    }
    
    func peek() -> Int? {
        return (disks.count > 0 ? disks[disks.count-1] : nil)
    }
    
    var description: String {
        var s = ""
        for i in disks { s += "\(i) " }
        return s
    }
}

func ==(lhs: Stack, rhs: Stack) -> Bool {
    return lhs.disks == rhs.disks
}