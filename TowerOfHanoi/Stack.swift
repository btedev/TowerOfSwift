//
//  Stack.swift
//
//  Created by BARRY EZELL on 6/14/14.
//  Copyright (c) 2014 Dockmarket LLC. All rights reserved.
//

import Foundation

class Stack {
    var disks = Array<Int>()
    
    init(var diskCount: Int = 0) {
        // Can't use "for in" enumeration because it only increments :/
        while (diskCount > 0) {
            push(diskCount--)
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
    
    func empty() -> Bool {
        return disks.count == 0
    }
}