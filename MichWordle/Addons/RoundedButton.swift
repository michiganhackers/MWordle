//
//  RoundedButton.swift
//
//  Created by Drew Scheffer on 5/9/21.
//

import Foundation
import UIKit

class RoundedButton: UIButton {
    
    var borderColor = UIColor.white.cgColor
    
    var highlightedColor = UIColor.white
    
    var defaultColor = UIColor.clear
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    required init?(coder: NSCoder) { //LIterally 0 clue what this is
        super.init(coder: coder)
    }
    
    func setup() {
        self.layer.borderWidth = 2
        //self.layer.borderColor = nil//borderColor
        self.layer.cornerRadius = 4 //self.frame.height / 2
        self.clipsToBounds = false
    }
}
