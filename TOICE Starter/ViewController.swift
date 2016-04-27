//
//  ViewController.swift
//  TOICE Starter
//
//  Created by tien on 4/26/16.
//  Copyright © 2016 Mango Solution. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var answerPickerView: UIPickerView!
    @IBOutlet weak var vocabularyLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    
    var selectAnswer = ""
    var score = 0
    var answerData = ["Bac Ky","Trung Ky","Name Ky","Tay Ky"]
    var words = [Word]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.answerPickerView.dataSource = self
        self.answerPickerView.delegate = self
        selectAnswer = answerData[0]
        scoreLabel.text = "0"
        
        //Load word from plist
        words = Word.loadAllWords("vocabulary")
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return words.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return words[row].vocabulary
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectAnswer = words[row].vocabulary
        
    }
    
    @IBAction func sendAnwserButon(sender: AnyObject) {
        vocabularyLabel.text = selectAnswer
        score += 1
        if score <= 10 {
            scoreLabel.text = String(score)

        }else{
            scoreLabel.text = "fucking bitch"
        }
        
    }
    

}

