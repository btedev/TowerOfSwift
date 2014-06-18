//
//  ViewController.swift
//  TowerOfHanoi
//
//  Created by BARRY EZELL on 6/13/14.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedDisks: Int?
    var game: Game?
    var timer: NSTimer?
    var onMove: Int = 0
    var totalMoves: Int = 0
    
    @IBOutlet var textView: UITextView
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func diskNumberSelected(sender: UISegmentedControl) {
        let diskSizes = [3,4,5,6,7,8,9]
        let selectedDisks = diskSizes[sender.selectedSegmentIndex]
        self.game = RecursiveGame(diskCount: selectedDisks)
        game!.solve()
        textView.text = ""
        onMove = 0
        totalMoves = game!.💾.count
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerTick", userInfo: nil, repeats: true)
        timer!.fire()
    }
    
    func timerTick() {
        updateUIState()
        
        if onMove == totalMoves {
            timer?.invalidate()
        }
    }
    
    func updateUIState() {
        if let move = game?.💾[onMove] {
          textView.text =  textView.text + move + "\n"
        }
        
        onMove += 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

