//
//  ViewController.swift
//  MichWordle
//
//  Created by MichHackers IOS TEAM on 2/3/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var keyboard: UIStackView!
    @IBOutlet weak var board: UIStackView!
    @IBOutlet weak var errorBar: UILabel!
    
    let word_length = 5
    let num_guesses = 6
    var boardLabels : [[UILabel]] = Array(repeating: Array(repeating: UILabel(), count: 5), count: 6)
    
    let cellBoarderColorVacant = UIColor.init(red: 0.20, green: 0.20, blue: 0.20, alpha: 1).cgColor
    let cellBoarderColorUsed = UIColor.init(red: 0.40, green: 0.40, blue: 0.40, alpha: 1).cgColor
    
    let blueColor = UIColor.init(red: 111/255.0, green: 178/255.0, blue: 210/255.0, alpha: 1).cgColor
    let yellowColor = UIColor.init(red: 215/255.0, green: 194/255.0, blue: 93/255.0, alpha: 1).cgColor

    var curr_row = 0
    var curr_col = 0
    
    let word_czar = DataInterface()
    let manager = GameManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillBoardLabels()
        
        
        boardLabels[2][3].text = "%"
        // Do any additional setup after loading the view.
        for i in 0..<boardLabels.count {
            for j in 0..<boardLabels[0].count {
                boardLabels[i][j].layer.borderWidth = 2
                boardLabels[i][j].layer.borderColor = cellBoarderColorVacant
                boardLabels[i][j].text = nil
            }
        }
        
        errorBar.center.y = -100
        errorBar.layer.cornerRadius = 10.0
        errorBar.clipsToBounds = true
        //TODO: When the view is rendered we dont want every label to just be "A".

    }
    
    //Populates the 2D array, boardLabels, with all the labels
    func fillBoardLabels() {
        let rows = board.subviews.filter({$0 is UIStackView})
        for i in 0..<rows.count{
            let curr_row = rows[i]
            let labels = curr_row.subviews.filter({$0 is UILabel})
            for j in 0..<labels.count {
            let curr_label = labels[j] as! UILabel
            boardLabels[i][j] = curr_label
          }
        }
      }
    
    func displayErrorMessage(withMessage msg: String) -> Void {
        errorBar.text = msg
        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionFlipFromTop) {
            self.errorBar.center.y = 140 // FIX THIS
        } completion: { (finished1) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                UIView.animate(withDuration: 0.5, delay: 0, options: .transitionFlipFromTop) {
                    self.errorBar.center.y = -140 // FIX THIS
                }
            }
        }
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    func getColorFromCode(_ letter: String) -> CGColor{
        if letter == "G"{
            return cellBoarderColorVacant
        }else if letter == "C" {
            return blueColor
        }else {
            return yellowColor
        }
    }
    
    func flip_the_row(row: Int, code: String, i: Int = 0) -> Void {
        
        UIView.transition(with: boardLabels[row][i], duration: 0.5, options: .transitionFlipFromTop) {
            let color = self.getColorFromCode(code[i])
            self.boardLabels[row][i].layer.backgroundColor = color
            self.boardLabels[row][i].layer.borderColor = color
        } completion: { (finished1) in
            if i == self.word_length - 1 {
                return;
            }
            self.flip_the_row(row: row, code: code, i: i+1)
        }
    }
    
    //Gets called whenever a keyboard button is pressed
    @IBAction func keyboardButtonPress(_ sender: Any) {
        let button = sender as! UIButton

        if (curr_col < word_length && curr_row < num_guesses){
            boardLabels[curr_row][curr_col].text = button.titleLabel!.text!
            boardLabels[curr_row][curr_col].layer.borderColor = cellBoarderColorUsed
        }
        
        
        if (curr_col != word_length){
            curr_col += 1
        }
        
        
        //TODO: This should call some function called "makeMove" or something that changes the appropriate label in boardLabels.
        // Think about what we need here... probably some way to tell what row and col we're on. When should the user be
        // allowed to make a move?
    }
    
    func gameOver(win: Bool){
        let message = win ? "GO BLUE!" : "Maybe next time..."
        
        displayErrorMessage(withMessage: message)
        delay(3.5) {
            self.performSegue(withIdentifier: "statsSegue", sender: self)
        }
    }
    
    func update_keyboard(keyboard_vals: [Int]){
        //Loop through keyboard
        let rows = keyboard.subviews.filter({$0 is UIStackView})
        for i in 0..<rows.count{
            var curr_row = rows[i]
            if (i == 2){ // Last row is different
                curr_row = curr_row.subviews.filter({$0 is UIStackView})[0]
            }
            let buttons = curr_row.subviews.filter({$0 is UIButton})
            for j in 0..<buttons.count {
                let curr_button = buttons[j] as! UIButton
                let letter = Character(curr_button.titleLabel?.text ?? "_")
                if letter.isLetter {
                    let idx = Int(letter.asciiValue! - Character("A").asciiValue!)
                    if keyboard_vals[idx] == 3{
                        curr_button.backgroundColor = UIColor(cgColor: blueColor)
                    }else if keyboard_vals[idx] == 2 {
                        curr_button.backgroundColor = UIColor(cgColor: yellowColor)
                    }else if keyboard_vals[idx] == 1 {
                        curr_button.backgroundColor = UIColor(cgColor: cellBoarderColorVacant)
                    }
                }
            }
        }
         
        
    }
    
    //TODO: Make an IBAction that gets called when the "submit button is pressed"
    
    @IBAction func backspacePressed(_ sender: Any) {
        if (curr_col == 0){return}
    
        curr_col -= 1
        boardLabels[curr_row][curr_col].text = nil
        boardLabels[curr_row][curr_col].layer.borderColor = cellBoarderColorVacant
        
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        var guess = ""
        
        //Only submit when it's a full guess
        if (curr_col < word_length){
            displayErrorMessage(withMessage: "Not enough letters")
            return
        }
        
        for i in 0..<word_length{
            let curr = boardLabels[curr_row][i].text!
            guess += curr
        }
        
        //If not a real word
        if (!word_czar.isRealWord(guess)){
            displayErrorMessage(withMessage: "That word seems faketown! Try again")
            return;
        }
        
        let code = manager.getCorrectCode(guess: guess)
        let keyboardVals = manager.getKeyboardVals()
        flip_the_row(row: curr_row, code: code)
        update_keyboard(keyboard_vals: keyboardVals)
        
        //WIN Condition
        if !code.contains("G") && !code.contains("Y") {
            delay(2.5) {
                self.gameOver(win: true)
            }
        }
        else if curr_row == num_guesses - 1 { //Lose Condition
            delay(2.5) {
                self.gameOver(win: false)
            }
        }
        
        curr_row += 1
        curr_col = 0
        
        
    }
    
}

//MARK: - Things That Probably Still Need To Be Added (Just some suggestions, you can add whatever you want)
//  - Settings page
//  - Stats page
//  - Help page
//  - Color of keys should change when the user submits
//  - Some "database of words"


