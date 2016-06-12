//
//  InfoViewController.swift
//  TOICE Starter
//
//  Created by tien tran on 6/11/16.
//  Copyright © 2016 Mango Solution. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    
    var highScore = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.updatingHighScore()
        //print(highScore)
        self.highScoreLabel.text = String(highScore)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // load High Score
    func updatingHighScore() {
        let highScoreDefault = NSUserDefaults.standardUserDefaults()
        if highScoreDefault.valueForKey("HighScore") != nil {
            highScore = highScoreDefault.valueForKey("HighScore") as! Int
        }
    }
}
