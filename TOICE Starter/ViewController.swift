//
//  ViewController.swift
//  TOICE Starter
//
//  Created by tien on 4/26/16.
//  Copyright © 2016 Mango Solution. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var answerPickerView: UIPickerView!
    @IBOutlet weak var vocabularyLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var backGroundImageView: UIImageView!
    
    
    
    var selectAnswer = ""
    var score = 0
    var words = [Word]()
    var newWords = [Word]()
    var shuffleNewWords = [Word]()
    let numberOfWords = 7
    
    var audioPlayer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add datasource and delegate
        self.answerPickerView.dataSource = self
        self.answerPickerView.delegate = self
        changeBackgroundWithAnimation("day_image")
        
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
    
    
    //==============Alert=============
    
    func throwAlert (title: String, message: String) {
        let alertView = UIAlertController(title: title , message: message, preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .Destructive , handler: {(alert: UIAlertAction) in self.changeBackgroundWithAnimation("day_image")}))
        //alertView.addAction(UIAlertAction(title: "Score board", style: .Default, handler: nil))
        presentViewController(alertView, animated: true, completion: nil)
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
    
    func reloadQuestion() {
        //load new question
        newWords = []
        makeRandomeAndRemove()
        vocabularyLabel.text = newWords[0].vocabulary     // get the word in the tile
        shuffleNewWords = newWords.shuffle()               // get the word for selection words
    }
    
    func changeBackgroundWithAnimation (imageName: String) {
        backGroundImageView.image = UIImage(named: imageName)
        backGroundImageView.layer.addAnimation(CATransition(), forKey: kCATransition)
    }
    
    func playSound (soundName: String, fileType: String) {
        let sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(soundName, ofType: fileType)!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: sound)
            audioPlayer.play()
        }catch {
            print("ERROR: Cannot playing sound named \(soundName)")
        }
        
    }
    
    
    

    //============================================================
    //MARK: Actions
    @IBAction func sendAnwserButon(sender: AnyObject) {
        
        if score < numberOfWords {
            if selectAnswer == newWords[0].vocabulary {     //anwser is correct
                playSound("correct", fileType: "mp3")
                score = score + 1
                scoreLabel.text = String(score)
                
                
            }else {                                        // answer is wrong
                playSound("wrong", fileType: "mp3")
                score = 0
                scoreLabel.text = String(score)
                words = Word.loadAllWords("vocabulary").shuffle()                // create new word array again, restart the game
                throwAlert("You lose!", message: "Press OK to retart the game")
                
            }
        } else {                                                                // when user win the game
            playSound("win", fileType: "mp3")
            score = 0
            scoreLabel.text = String(score)
            words = Word.loadAllWords("vocabulary").shuffle()
            throwAlert("You win!", message: "Press OK to retart the game")
            
        }
        
        // change backgrond following score
        switch score {
        case 3:
            changeBackgroundWithAnimation("night_image")
            break
        default:
            break
        }
        
        //reload picker view
        reloadQuestion()
        answerPickerView.reloadAllComponents()
      
    }
    

}

