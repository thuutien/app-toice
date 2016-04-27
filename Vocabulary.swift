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
    
}

// MARK: - Support for loading data from plist

extension Word {
    
    static func loadAllWords(fileName: String) -> [Word] {
        return loadWordFromPlistNamed(fileName)
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
                let vocabulary          = dict["vocabulary"]          as? String
                else {
                    fatalError("Error parsing dict \(dict)")
            }
            
            let word = Word(
                identifier: identifier,
                vocabulary: vocabulary
            )
            
            words.append(word)
        }
        
        return words
    }
}