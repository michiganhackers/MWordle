//
//  FlipViewController.swift
//  MichWordle
//
//  Created by Drew Scheffer on 2/9/22.
//

import UIKit

class IntroAnimationViewController: UIViewController {

    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        let image = UIImage(named: "download-2")
        myButton.setImage(image, for: .normal)
        UIView.transition(with: myButton, duration: 1.0, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
