//
//  ThemeButtons.swift
//  Memorization Exercise Game
//
//  Created by Kien Phan on 1/8/18.
//  Copyright © 2018 Kien Phan. All rights reserved.
//

import UIKit

class ThemeButtons: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = frame.size.height/3
        layer.masksToBounds = true
    }

}
