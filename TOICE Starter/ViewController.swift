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
        words = Word.loadAllWords("vocabulary").shuffle()
        newWords = get3Words(words)
        
        
       
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
            return newWords[row].meaning
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectAnswer = newWords[row].vocabulary
        
    }
    
    
    
    
    
    //MARK: Get random data from array --> bi duplicate
    
    //get random word from array
    
    //New randome function
    
    func getRandomFromArray(myArray: [Word]) -> Word {
        let randomIndex = arc4random_uniform(UInt32(myArray.count))
        return myArray[Int(randomIndex)]
        
    }
    
    func get3Words(myArray: [Word]) -> [Word] {
        var newArray:[Word] = []
        let word1:Word = getRandomFromArray(myArray)
        newArray.append(word1)
        
        var word2: Word = getRandomFromArray(myArray)
        for var i in 0..<myArray.count{
            if word2.identifier != word1.identifier {
                newArray.append(word2)
                break
            }else {
                word2 = getRandomFromArray(myArray)
            }
            i += 1
        }
        
        var word3: Word = getRandomFromArray(myArray)
        for var i in 0..<myArray.count{
            if word3.identifier != word1.identifier && word3.identifier != word2.identifier {
                newArray.append(word3)
                break
            }else {
                word3 = getRandomFromArray(myArray)
            }
            i += 1
        }
        return newArray
    }
    
    

    //============================================================
    //MARK: Actions
    @IBAction func sendAnwserButon(sender: AnyObject) {
        newWords = get3Words(words)
        vocabularyLabel.text = selectAnswer
        score += 1
        if score <= 10 {
            scoreLabel.text = String(score)

        }else{
            scoreLabel.text = "fucking bitch"
        }
        
        //newWords = getRandomWord(words)
        answerPickerView.reloadAllComponents()
    }
    

}

