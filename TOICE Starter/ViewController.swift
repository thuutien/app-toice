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
    var shuffleNewWords: [Word] = []
    let numberOfWords = 7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add datasource and delegate
        self.answerPickerView.dataSource = self
        self.answerPickerView.delegate = self
        
        //MARK: Setup data
        scoreLabel.text = "0"
        
        //Load word from plist
        words = Word.loadAllWords("vocabulary").shuffle()
        makeRandomeAndRemove()
        vocabularyLabel.text = newWords[0].vocabulary
        shuffleNewWords = newWords.shuffle()
        
        
       
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
        return shuffleNewWords.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return shuffleNewWords[row].meaning
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectAnswer = shuffleNewWords[row].vocabulary
        
    }
    
    
    
    
    //============================================================
    //MARK: Get random data from array 
    func makeRandomeAndRemove () {
        words = words.shuffle()
        for i in 0..<3 {
            newWords.append(words[i])
        }
        words.removeAtIndex(0)
    }
    
    

    //============================================================
    //MARK: Actions
    @IBAction func sendAnwserButon(sender: AnyObject) {
        
        if score < numberOfWords {
            if selectAnswer == newWords[0].vocabulary {
                score = score + 1
                scoreLabel.text = String(score)
            }else {
                score = 0
                scoreLabel.text = String(score)
                score = 0
                let alertView = UIAlertController(title: "You lose!", message: "Press OK to retart the game", preferredStyle: .Alert)
                alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil ))
                alertView.addAction(UIAlertAction(title: "Score board", style: .Default, handler: nil))
                presentViewController(alertView, animated: true, completion: nil)
                words = Word.loadAllWords("vocabulary").shuffle()
            }

        } else {
            score = 0
            scoreLabel.text = String(score)
            let alertView = UIAlertController(title: "You win!", message: "Press OK to retart the game", preferredStyle: .Alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil ))
            alertView.addAction(UIAlertAction(title: "Score board", style: .Default, handler: nil))
            presentViewController(alertView, animated: true, completion: nil)
           
            
        }
        
        
        print(score)
        
        //Load for new round
        newWords = []
        makeRandomeAndRemove()
        vocabularyLabel.text = newWords[0].vocabulary
        shuffleNewWords = newWords.shuffle()
        
        //reload picker view
        answerPickerView.reloadAllComponents()
      
    }
    

}

