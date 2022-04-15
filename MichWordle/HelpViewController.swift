//
//  HelpViewController.swift
//  MichWordle
//
//  Created by Drew Scheffer on 3/10/22.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    
    @IBOutlet weak var firstExample: UIStackView!
    @IBOutlet weak var secondExample: UIStackView!
    var ex1Labels : [UILabel] = Array(repeating: UILabel(), count: 5)
    var ex2Labels : [UILabel] = Array(repeating: UILabel(), count: 5)

    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        
        populateLabels()
        delay(0.4) {
            self.flipAnimations()
        }
        
    }
    
    func flipAnimations() {
        //Example 1
        for i in 0..<5{
            UIView.transition(with: ex1Labels[i], duration: 1, options: .transitionFlipFromTop, animations: {
                if i == 0 {
                    self.ex1Labels[i].layer.backgroundColor = blueColor
                    self.ex1Labels[i].layer.borderColor = blueColor
                }else{
                    self.ex1Labels[i].layer.backgroundColor = cellBoarderColorUsed
                    self.ex1Labels[i].layer.borderColor = cellBoarderColorUsed
                }
            }, completion: nil)
        }
        
        //Example 2
        for i in 0..<5{
            UIView.transition(with: ex2Labels[i], duration: 1, options: .transitionFlipFromTop, animations: {
                if i == 2 {
                    self.ex2Labels[i].layer.backgroundColor = yellowColor
                    self.ex2Labels[i].layer.borderColor = yellowColor
                }else{
                    self.ex2Labels[i].layer.backgroundColor = cellBoarderColorUsed
                    self.ex2Labels[i].layer.borderColor = cellBoarderColorUsed
                }
            }, completion: nil)
        }

    }
    
    func populateLabels() {
        //First Example
        var labels = firstExample.subviews.filter({$0 is UILabel})
        for i in 0..<labels.count {
            let curr_label = labels[i] as! UILabel
            ex1Labels[i] = curr_label
        }
        
        //First Example
        labels = secondExample.subviews.filter({$0 is UILabel})
        for i in 0..<labels.count {
            let curr_label = labels[i] as! UILabel
            ex2Labels[i] = curr_label
        }
        
        for i in 0..<ex1Labels.count {
            ex1Labels[i].layer.borderWidth = 2
            ex1Labels[i].layer.borderColor = cellBoarderColorVacant
            
            ex2Labels[i].layer.borderWidth = 2
            ex2Labels[i].layer.borderColor = cellBoarderColorVacant
        }
        
        
    }
    

    @IBAction func dismissButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
