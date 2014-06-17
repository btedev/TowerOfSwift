//
//  ViewController.swift
//  TowerOfHanoi
//
//  Created by BARRY EZELL on 6/13/14.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var game = Game(diskCount: 9)
        game.solve()
        for s in game.log {
            println(s)
        }
        
        println("Total moves = \(game.log.count)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

