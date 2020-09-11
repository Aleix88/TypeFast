//
//  GameManager.swift
//  TypeFast
//
//  Created by Aleix Diaz Baggerman on 10/09/2020.
//  Copyright © 2020 Aleix Diaz Baggerman. All rights reserved.
//

import Foundation

class GameManager {
    
    private var wordIndex = 0
    private var words: [String] = []
    
    var characterIndex: Int = 0
    var currentWord: String? = ""

    func startNewGame() {
        self.words = ["link", "development", "mobile"]
        self.currentWord = self.words.first!
        self.wordIndex = 0
        self.characterIndex = 0
    }
    
    func checkCharInput(char: String) -> Bool {
        guard let currentWord = self.currentWord else {return false}
        guard self.characterIndex < currentWord.count else {return false}
        let currentCharacter = currentWord[self.characterIndex]
        
        if (char == String(currentCharacter)) {
            self.characterIndex += 1
            return true
        }
        return false
    }
    
    func nextWord() -> String? {
        guard self.words.count > self.wordIndex else {return nil}
        return self.words[wordIndex]
    }
 
    func nextWordIfCompleted() -> Bool {
        guard let currentWord = self.currentWord else {return false}
        if (currentWord.count <= self.characterIndex) {
            guard self.wordIndex + 1 < self.words.count else {
                self.wordIndex += 1
                return true
            }
            self.wordIndex += 1
            self.characterIndex = 0
            self.currentWord = self.words[self.wordIndex]
            return true
        }
        return false
    }
    
    func areWordsFinished() -> Bool {
        return self.wordIndex >= self.words.count
    }
    
    func numberOfWords() -> Int {
        return self.words.count
    }
    
}
