//
//  GameManager.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 10/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import Foundation

class GameManager {
    
    private var currentWord: String = ""
    private var characterIndex: Int = 0
    private var wordIndex = 0
    private var words: [String] = []
    
    func startNewGame() {
        self.words = ["link", "development", "mobile"]
        self.currentWord = self.words.first!
        self.wordIndex = 0
        self.characterIndex = 0
    }
    
    func checkCharInput(char: String) -> Bool {
        let currentCharacter = self.currentWord[self.characterIndex]
        
        if (char == String(currentCharacter)) {
            self.characterIndex += 1
            return true
        }
        return false
    }
 
    func nextWordIfCompleted() -> Bool {
        if (self.currentWord.count == self.characterIndex + 1) {
            guard self.wordIndex + 1 < self.words.count else {return true}
            self.wordIndex += 1
            self.currentWord = self.words[self.wordIndex]
            return true
        }
        return false
    }
    
    func areWordsFinished() -> Bool {
        return self.wordIndex + 1 >= self.words.count
    }
    
}
