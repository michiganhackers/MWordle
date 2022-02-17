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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridLetter.backgroundColor = UIColor.yellow
        fillBoardLabels()
        boardLabels[2][3].text = "%"
        // Do any additional setup after loading the view.
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
    
    
    @IBAction func keyboardButtonPress(_ sender: Any) {
        let button = sender as! UIButton
        print(button.titleLabel!.text!)
    }
    @IBOutlet weak var gridLetter: UILabel!
    
}

