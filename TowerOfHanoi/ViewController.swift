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
    var stackViews: Array<UIView> = []
    let stackViewSize = CGSize(width: 250, height: 550)
    let maxDiskWidth:Float
    let minDiskWidth:Float = 50
    let diskHeight: Float
    let maxDiskCount = 10
    let diskSizeIncrement: Float
    let colors: Array<UIColor>
    
    @IBOutlet var diskSelectionControl: UISegmentedControl
    @IBOutlet var countdownLabel: UILabel
    
    init(coder aDecoder: NSCoder!) {
        maxDiskWidth = stackViewSize.width
        diskHeight = stackViewSize.height / Float(maxDiskCount)
        diskSizeIncrement = (maxDiskWidth - minDiskWidth) / Float(maxDiskCount-1)
        
        let color1 = UIColor(red: 0.333, green: 0.855, blue: 0.822, alpha:1.0)
        let color2 = UIColor(red: 0.524, green: 0.916, blue: 0.760, alpha:1.0)
        let color3 = UIColor(red: 0.714, green: 0.976, blue: 0.698, alpha:1.0)
        colors = [color1, color2, color3]
        
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = UIColor(red: 0.266, green: 0.696, blue: 0.976, alpha: 1.0)
        countdownLabel.textColor = view.tintColor
        
        for i in (0..3) {
            // Fun with Swift's strict numeric types. See the forums and
            // "Integer and Floating-Point Conversion” in the iBook
            // "The Swift Programming Language"
            let centerX = Float(self.view.bounds.size.width / 4.0) * Float(i+1)
            let x = centerX - Float(stackViewSize.width / 2)
            var stackRect = CGRect(x: x, y: 100.0 , width: stackViewSize.width, height: stackViewSize.height )
            var stackView = UIView(frame: stackRect)
            view.addSubview(stackView)
            stackViews += stackView
        }
    }

    @IBAction func diskNumberSelected(sender: UISegmentedControl) {
        let selectedDisks = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex).toInt()!
        game = RecursiveGame(diskCount: selectedDisks)
        game!.solve()
        
        onMove = 0
        totalMoves = game!.💾.count
        
        updateUIState()
        
        if timer {
            timer!.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.75, target: self, selector: "timerTick", userInfo: nil, repeats: true)
    }
    
    func timerTick() {
        updateUIState()
        
        if onMove == totalMoves {
            timer?.invalidate()
            diskSelectionControl.selectedSegmentIndex = UISegmentedControlNoSegment
            countdownLabel.text = "0"
        }
    }
    
    func updateUIState() {
        countdownLabel.text = "\(totalMoves-onMove-1)"
        
        if let move = game?.💾[onMove] {
            var idx = 0
            for stackArr in parseStackDescription(move) {
                renderStack(idx++, stack: stackArr)
            }
        }
        
        onMove += 1
    }
    
    // Convert description string like "A:3,2|B:|C:1"
    // to [[3,2],[],[1]]
    func parseStackDescription(desc: String) -> Array<Array<Int>> {
        let stackStrings = desc.componentsSeparatedByString("|")
        var stacks: Array<Array<Int>> = []
        
        for idx in (0..stackStrings.count) {
            let stackString = stackStrings[idx].substringFromIndex(2)
            
            if countElements(stackString) > 0 {
                stacks += stackString.componentsSeparatedByString(",").map { $0.toInt()! }
            } else {
                stacks += Array<Int>()
            }
        }
        
        return stacks
    }
    
    func renderStack(idx: Int, stack: Array<Int>) {
        let stackView = stackViews[idx]
        for subview : AnyObject in stackView.subviews {
            subview.removeFromSuperview()
        }
        
        var diskNum = 1
        for disk in stack {
            let width = minDiskWidth + (diskSizeIncrement * Float(disk-1))
            let x = (maxDiskWidth - width) / 2
            let y = stackViewSize.height - (diskHeight * Float(diskNum))
            let diskView = UIView(frame: CGRect(x: x, y: y, width: width, height: diskHeight))
            diskView.backgroundColor = colors[disk % colors.count]
            stackView.addSubview(diskView)
            diskNum++
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
