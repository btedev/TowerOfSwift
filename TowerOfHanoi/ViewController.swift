//
//  ViewController.swift
//  TowerOfHanoi
//
//  Created by BARRY EZELL on 6/13/14.
//  Copyright (c) 2014 Dockmarket LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var game = Game(diskCount: 3)
        game.solve()
        for s in game.log {
            println(s)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

