
//
//  SelectedTheme.swift
//  Memorization Exercise Game
//
//  Created by Kien Phan on 1/9/18.
//  Copyright © 2018 Kien Phan. All rights reserved.
//

import Foundation

class SelectedTheme {
    static var selectedTheme = ThemeEnum.classic
    
    //MARK: load saved selected theme
    static func loadSavedSelectedTheme() {
        if let selectedThemeNum = UserDefaults.standard.value(forKey: "selectedThemeNum") as? Int{ //check if there is a selectedTheme in memory
            switch selectedThemeNum {
            case 0:
                selectedTheme = .classic
            case 1:
                selectedTheme = .computerized
            case 2:
                selectedTheme = .Ensteinized
            default:
                print("ERROR OCCUR AT: loadSavedSelectedTheme switch!")
            }
        }
    }
}
