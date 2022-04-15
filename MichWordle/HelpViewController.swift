//
//  HelpViewController.swift
//  MichWordle
//
//  Created by Drew Scheffer on 3/10/22.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
    }
    

    @IBAction func dismissButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
