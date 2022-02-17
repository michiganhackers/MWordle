//
//  ViewController.swift
//  MichWordle
//
//  Created by Drew Scheffer on 2/3/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var board: UIStackView!
        
    var boardLabels : [[UILabel]] = Array(repeating: Array(repeating: UILabel(), count: 5), count: 6)
    
    let cellBoarderColor = UIColor.init(red: 0.24, green: 0.24, blue: 0.24, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        init_board()
        fillBoardLabels()
        
        boardLabels[2][3].text = "%"
    }
    
    
    
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
    
    //Draws borders and gets rid of text
    func init_board() {
        let rows = board.subviews.filter({$0 is UIStackView})
        for row in rows{
            let labels = row.subviews.filter({$0 is UILabel})
            for label in labels {
                let curr_label = label as! UILabel
                curr_label.layer.borderColor = cellBoarderColor
                curr_label.layer.borderWidth = 2
                curr_label.layer.cornerRadius = 2
                curr_label.text = nil
            }
        }
    }


}

