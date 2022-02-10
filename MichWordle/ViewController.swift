//
//  ViewController.swift
//  MichWordle
//
//  Created by Drew Scheffer on 2/3/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var board: UIStackView!
    
    let cellBoarderColor = UIColor.init(red: 0.24, green: 0.24, blue: 0.24, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        init_board()
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

