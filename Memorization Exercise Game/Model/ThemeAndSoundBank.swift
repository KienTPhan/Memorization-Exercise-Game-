//
//  ThemeAndSoundBank.swift
//  Memorization Exercise Game
//
//  Created by Kien Phan on 1/9/18.
//  Copyright © 2018 Kien Phan. All rights reserved.
//

import Foundation
import UIKit
class ThemeAndSoundBank {
    
    var themesArray = [Theme]()
    
    //Classic theme
    let classicThemeColorArray = [#colorLiteral(red: 0.09549108893, green: 0.705386281, blue: 0.5668753982, alpha: 1),#colorLiteral(red: 0.1640232503, green: 0.5201874375, blue: 0.786051333, alpha: 1),#colorLiteral(red: 0.9385668039, green: 0.7341745496, blue: 0.07240287215, alpha: 1),#colorLiteral(red: 0.824475348, green: 0.2375188172, blue: 0.1928428113, alpha: 1),#colorLiteral(red: 0.1508485675, green: 0.2066769898, blue: 0.2731922865, alpha: 1),#colorLiteral(red: 0.386837393, green: 0.2707623541, blue: 0.2233551741, alpha: 1),#colorLiteral(red: 0.9606800675, green: 0.9608444571, blue: 0.9606696963, alpha: 1)]
    let classicSound = "note"
    
    //Computerize theme
    let computerizeThemeColorArray = [#colorLiteral(red: 0.820582613, green: 0.820582613, blue: 0.820582613, alpha: 1),#colorLiteral(red: 0.7543633644, green: 0.7543633644, blue: 0.7543633644, alpha: 1),#colorLiteral(red: 0.701462766, green: 0.701462766, blue: 0.701462766, alpha: 1),#colorLiteral(red: 0.6515957447, green: 0.6515957447, blue: 0.6515957447, alpha: 1),#colorLiteral(red: 0.5490359043, green: 0.5490359043, blue: 0.5490359043, alpha: 1),#colorLiteral(red: 0.4696850066, green: 0.4696850066, blue: 0.4696850066, alpha: 1),#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)]
    let computerizeSound = "comp"
    
    //Einsteinize
    let einsteinizeThemeColorArray = [#colorLiteral(red: 0.8269490347, green: 0.3573489321, blue: 0.00761648218, alpha: 1),#colorLiteral(red: 0.77858107, green: 0.336447716, blue: 0.007170996757, alpha: 1),#colorLiteral(red: 0.6967236584, green: 0.3010747275, blue: 0.006417062123, alpha: 1),#colorLiteral(red: 0.6067162958, green: 0.2621799063, blue: 0.005588063667, alpha: 1),#colorLiteral(red: 0.5396862729, green: 0.2332142674, blue: 0.004970694333, alpha: 1),#colorLiteral(red: 0.4546793194, green: 0.1964802695, blue: 0.004187751347, alpha: 1),#colorLiteral(red: 0.07597048579, green: 0.4546793194, blue: 0.1009806446, alpha: 1)]
    let einsteinizeSound = "ein"
    
    init(){
        themesArray.append(Theme(buttonsColors: classicThemeColorArray, buttonsSound: classicSound, themeImage: "einsteinize")) //themeImage is set the einsteinize just for caughtion will never be use
        themesArray.append(Theme(buttonsColors: computerizeThemeColorArray, buttonsSound: computerizeSound, themeImage: "computerize")) //need fix
        themesArray.append(Theme(buttonsColors: einsteinizeThemeColorArray, buttonsSound: einsteinizeSound, themeImage: "einsteinize"))
    }
}
