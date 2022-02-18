//
//  FlipViewController.swift
//  MichWordle
//
//  Created by Drew Scheffer on 2/9/22.
//

import UIKit

class IntroAnimationViewController: UIViewController {

    @IBOutlet weak var mButton: UIButton!
    @IBOutlet weak var letters: UIStackView!
    
    let wait_time = 1.0 // In secs
    let flip_dur = 0.5

    override func viewDidLoad() {
        letters.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mButton.center = self.view.center
        let flipped = UIImage(named: "w")

        UIView.animate(withDuration: 0.75, delay: 1, options: .transitionFlipFromTop, animations: {
            self.mButton.center.x = self.letters.frame.origin.x - self.mButton.frame.width/2
        }) { (finished) in
            //Flip the the W
            let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromTop]
            UIView.transition(with: self.mButton, duration: 0.75, options: transitionOptions, animations: {
                self.mButton.setImage(flipped, for: .normal)
            }) { (finished2) in
                UIView.transition(with: self.letters, duration: 0.75, options: transitionOptions, animations: {
                    self.letters.isHidden = false
                }) { (finished3) in
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.wait_time) {
                        self.performSegue(withIdentifier: "finishedAnimation", sender: self)
                    }
                }
            }
        }
        
        
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + self.wait_time) {
//            self.mButton.setImage(flipped, for: .normal)
//            UIView.transition(with: self.mButton, duration: self.flip_dur, options: .transitionFlipFromTop, animations: nil) { (finished) in
//                //nothing
//            }
//        }
    }

}
