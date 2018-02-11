//
//  RoundEdgeButtons.swift
//  Memorization Exercise Game
//
//  Created by Kien Phan on 1/7/18.
//  Copyright © 2018 Kien Phan. All rights reserved.
//

import UIKit

class RoundEdgeButtons: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = frame.size.height/3
        layer.masksToBounds = true
    }
    
    override var isHighlighted: Bool {
        didSet { // this run when isHighlighted value is changed from true to false or false to true
            if isHighlighted {
                alpha = 1.0
            } else {
                alpha = 0.5
            }
        }
    }
    
}
