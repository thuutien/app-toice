//
//  Vocabulary.swift
//  TOICE Starter
//
//  Created by tien on 4/27/16.
//  Copyright © 2016 Mango Solution. All rights reserved.
//

import Foundation


struct  Word {
    let identifier: Int
    let vocabulary: String
    let meaning: String
    
}

// MARK: - Support for loading data from plist

extension Word {
    
    static func loadAllWords(fileName: String) -> [Word] {
        return loadWordFromPlistNamed(fileName)
    }
    
    static func makeRandomeArrayTest (arrayName: [Word]) -> [Word] {
        return arrayName.shuffle()
    }
    
    private static func loadWordFromPlistNamed(plistName: String) -> [Word] {
        guard
            let path = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist"),
            let dictArray = NSArray(contentsOfFile: path) as? [[String : AnyObject]]
            else {
                fatalError("An error occurred while reading \(plistName).plist")
        }
        
        var words = [Word]()
        
        for dict in dictArray {
            guard
                let identifier          = dict["identifier"]          as? Int,
                let vocabulary          = dict["vocabulary"]          as? String ,
                let meaning             = dict["meaning"]             as? String
                else {
                    fatalError("Error parsing dict \(dict)")
            }
            
            let word = Word(
                identifier: identifier ,
                vocabulary: vocabulary ,
                meaning: meaning
            )
            
            words.append(word)
        }
        
        return words
    }
}

extension MutableCollectionType where Self.Index == Int {
    func shuffle() -> Self {
        var r = self
        let c = self.count
        for i in 0..<(c - 1) {
            let j = Int(arc4random_uniform(UInt32(c - i))) + i
            if i != j {
                swap(&r[i], &r[j])
            }
        }
        return r
    }
}




