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
    //var answerData = ["Bac Ky","Trung Ky","Name Ky","Tay Ky"]
    var words = [Word]()
    var newWords = [Word]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add datasource and delegate
        self.answerPickerView.dataSource = self
        self.answerPickerView.delegate = self
        
        //MARK: Setup data
        scoreLabel.text = "0"
        
        //Load word from plist
        words = Word.loadAllWords("vocabulary")
        newWords = makeRandomArray(words)
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //============================================================
    //MARK: UIPickerView datasource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return newWords.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return newWords[row].vocabulary
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectAnswer = newWords[row].vocabulary
        
    }
    
    
    
    //MARK: Get random data from array
    func makeRandomArray( wordArray: [Word]) -> [Word] {
        var newArray: [Word] = []
        for var i in 0..<3 {
            let randomValue = arc4random_uniform(UInt32(wordArray.count))
            newArray.append(wordArray[Int(randomValue)])
            //wordArray.removeAtIndex(Int(randomValue))
            i += i
        }
        
        return newArray
    }
    //get random word from array
    func getRandomFromArray(wordArray: [Word]) -> Word {
        let randomValue = arc4random_uniform(UInt32(wordArray.count))
        let randomWord = wordArray[Int(randomValue)]
        return randomWord
    }
   

    //============================================================
    //MARK: Actions
    @IBAction func sendAnwserButon(sender: AnyObject) {
        
        vocabularyLabel.text = selectAnswer
        score += 1
        if score <= 10 {
            scoreLabel.text = String(score)

        }else{
            scoreLabel.text = "fucking bitch"
        }
        
        newWords = getRandomWord(words)
        answerPickerView.reloadAllComponents()
    }
    

}

