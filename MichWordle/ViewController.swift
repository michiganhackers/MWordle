//
//  ViewController.swift
//  MichWordle
//
//  Created by MichHackers IOS TEAM on 2/3/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var board: UIStackView!
        
    var boardLabels : [[UILabel]] = Array(repeating: Array(repeating: UILabel(), count: 5), count: 6)
    
    let cellBoarderColor = UIColor.init(red: 0.24, green: 0.24, blue: 0.24, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillBoardLabels()
        
        
        boardLabels[2][3].text = "%"
        // Do any additional setup after loading the view.
        for i in 0..<boardLabels.count {
            for j in 0..<boardLabels[0].count {
                boardLabels[i][j].layer.borderWidth = 2
                boardLabels[i][j].layer.borderColor = cellBoarderColor
                boardLabels[i][j].text = nil
            }
        }
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
    
    //Gets called whenever a keyboard button is pressed
    @IBAction func keyboardButtonPress(_ sender: Any) {
        let button = sender as! UIButton
        print(button.titleLabel!.text!)
        //TODO: This should call some function called "makeMove" or something that changes the appropriate label in boardLabels.
        // Think about what we need here... probably some way to tell what row and col we're on. When should the user be
        // allowed to make a move?
    }
    
    //TODO: Make an IBAction that gets called when the "submit button is pressed"
    
}

//MARK: - Things That Probably Still Need To Be Added (Just some suggestions, you can add whatever you want)
//  - Settings page
//  - Stats page
//  - Help page
//  - Title Label
//  - Color of keys should change when the user submits
//  - Some "database of words"


