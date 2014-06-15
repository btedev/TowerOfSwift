//
//  Game.swift
//  TowerOfHanoi
//
//  Created by BARRY EZELL on 6/14/14.
//  Copyright (c) 2014 Dockmarket LLC. All rights reserved.
//

import Foundation

enum Peg: Int {
    case A = 0, B, C
}

class Game {
    var stacks: Dictionary<Peg, Stack>
    var log = Array<(Int, Peg, Peg)>()
    
    init(diskCount: Int) {
        stacks = [
            Peg.A : Stack(diskCount : diskCount),
            Peg.B : Stack(),
            Peg.C : Stack()
        ]
    }
    
    func ended() -> Bool {
        for (peg, stack) in stacks {
            if (peg == .A || peg == .B) && !stack.empty() {
                return false
            }
        }
        return true
    }
    
    func play() {
        while !ended() {
            
        }
    }
}