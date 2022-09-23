//
//  test.swift
//  MichWordle
//
//  Created by Michgan hackers on 4/11/22.
//

import Foundation

class GameManager {
    let wordDatabase = WordDatabase()
    var keyboardVals: [Int] = Array(repeating: 0, count: 26)
    
    var word_length: Int {
        return wordDatabase.word.count
    }
    
    func newGame() -> Void {
        wordDatabase.incrementWordPointer()
        keyboardVals = Array(repeating: 0, count: 26)
    }
    
    func updateKeyboardVals(guess: String, code: String){
        //update all the blues
        for i in 0..<guess.count {
            if code[i] == "C" {
                let letter_idx = Int(UnicodeScalar(guess[i])!.value - UnicodeScalar("A").value)
                keyboardVals[letter_idx] = 3
            }
        }
        
        //update all the yellows
        for i in 0..<guess.count {
            if code[i] == "Y" {
                let letter_idx = Int(UnicodeScalar(guess[i])!.value - UnicodeScalar("A").value)
                if (keyboardVals[letter_idx] < 2){
                    keyboardVals[letter_idx] = 2
                }
            }
        }
        
        //update all the yellows
        for i in 0..<guess.count {
            if code[i] == "G" {
                let letter_idx = Int(UnicodeScalar(guess[i])!.value - UnicodeScalar("A").value)
                if (keyboardVals[letter_idx] == 0){
                    keyboardVals[letter_idx] = 1
                }
            }
        }
    }
    
    func getKeyboardVals() -> [Int]{
        return keyboardVals
    }
    
    func getCorrectCode(guess: String) -> String{
        let word = wordDatabase.word
        let l_guess = guess.lowercased()
        var curr_word = word
        var code: String = String(repeating: "G", count: guess.count) // "GGGGGGGG"
        
        //Get all the correct letters first
        for i in 0..<word.count {
            if (l_guess[i] == curr_word[i]){
                code = replace(myString: code, i, "C")
                curr_word = replace(myString: curr_word, i, "_")
            }
        }
        
        //Now get all the ones in the wrong place
        for i in 0..<word.count {
            if (code[i] == "C"){
                continue
            }

            if (curr_word.contains(l_guess[i])){
                code = replace(myString: code, i, "Y")
                //Remove first occurance in word
                let firstOccInd = firstOccurance(str: curr_word, ch: l_guess[i])
                curr_word = replace(myString: curr_word, firstOccInd, "_")
            }
        }
        
        updateKeyboardVals(guess: guess, code: code)
        return code
    }
    
    //Replaces char in string
    func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
        var chars = Array(myString)     // gets an array of characters
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
    
    //First occurance of char in string
    func firstOccurance(str: String, ch: String) -> Int{
        for i in 0..<str.count {
            if str[i] == ch {
                return i;
            }
        }
        return -1;
    }
}
