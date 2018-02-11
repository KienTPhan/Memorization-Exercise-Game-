//
//  Theme.swift
//  Memorization Exercise Game
//
//  Created by Kien Phan on 1/9/18.
//  Copyright © 2018 Kien Phan. All rights reserved.
//

import Foundation
import UIKit
class Theme {
    var buttonsColors = [UIColor]()
    var buttonsSound = ""
    var themeImage = ""
    init(buttonsColors: [UIColor], buttonsSound: String, themeImage: String) {
        self.buttonsColors = buttonsColors
        self.buttonsSound = buttonsSound
        self.themeImage = themeImage
    }
}
