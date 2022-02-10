//
//  SpecialLabel.swift
//  MichWordle
//
//  Created by Drew Scheffer on 2/3/22.
//

import Foundation
import UIKit

class BoarderedLabel: UILabel {
    var borderColor = UIColor.white.cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) { //LIterally 0 clue what this is
        super.init(coder: coder)
    }
    
    func setup() {
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = 1 //self.frame.height / 2
        self.clipsToBounds = true
    }
    
    
    
}
