//
//  ThemeSoundViewController.swift
//  Memorization Exercise Game
//
//  Created by Kien Phan on 1/8/18.
//  Copyright © 2018 Kien Phan. All rights reserved.
//

import UIKit

class ThemeSoundViewController: UIViewController {
    
    @IBOutlet var themeButtons: [ThemeButtons]!
    
    //MARK: declares variables
    var activeTheme = ThemeEnum.classic
    var highscore = HighscoreHandler.highscore
    
    //MARK: viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSavedSelectedTheme()
        changeSelectedTheme()
        lockThemes()//testing
    }
    
    override func viewDidAppear(_ animated: Bool) {
        highscore = HighscoreHandler.highscore //make sure to update the highscore after the user go back to unlock view
        unlockReward(highscore: highscore)
        print("Highscore = \(highscore)")
    }
    
    //MARK: make sure the selected button is highlighted
    func changeSelectedTheme() {
        //unhilights all buttons
        for button in themeButtons {
            button.alpha = 0.5
        }
        
        //highlight the right button and make sure the  selected theme is save
        switch(activeTheme) {
        case .classic:
            themeButtons[0].alpha = 1
            
        case .computerized:
            themeButtons[1].alpha = 1

        case .Ensteinized:
            themeButtons[2].alpha = 1

        }
    }
    
    //MARK: make it so when I click a button make that button the activeTheme
    
    @IBAction func themeButtonsTapped(_ sender: ThemeButtons) {
        switch sender.tag {
        case 0:
            activeTheme = .classic
            changeSelectedTheme()
            saveSelectedTheme(themeNum: 0)
            
        case 1:
            activeTheme = .computerized
            changeSelectedTheme()
            saveSelectedTheme(themeNum: 1)
            
        case 2:
            activeTheme = .Ensteinized
            changeSelectedTheme()
            saveSelectedTheme(themeNum: 2)
            
        default:
            print("Error occured at: themeButtonsTapped! switch")
        }
        SelectedTheme.selectedTheme = activeTheme //Link the two view selectedTheme together using selectedTheme.swift

    }
    
    //MARK: Save user's selected activeTheme function
    func saveSelectedTheme(themeNum: Int) {
        UserDefaults.standard.set(themeNum, forKey: "selectedThemeNum")
    }
    
    //MARK: load saved selected theme
    func loadSavedSelectedTheme() {
        if let selectedThemeNum = UserDefaults.standard.value(forKey: "selectedThemeNum") as? Int{ //check if there is a selectedTheme in memory
            switch selectedThemeNum {
            case 0:
                self.activeTheme = .classic
            case 1:
                self.activeTheme = .computerized
            case 2:
                self.activeTheme = .Ensteinized
            default:
                print("ERROR OCCUR AT: loadSavedSelectedTheme switch!")
            }
        }
    }
    
    //MARK: unlock rewards
    func unlockReward(highscore: Int){
        if highscore > 9 {
            themeButtons[1].isEnabled = true
            themeButtons[1].setTitle("Computerize", for: .normal)
        }
        if highscore > 19 {
            themeButtons[2].isEnabled = true
            themeButtons[2].setTitle("Einsteinize", for: .normal)
        }
    }
    
    //MARK: lockup rewards
    func lockThemes() {
        themeButtons[1].isEnabled = false
        themeButtons[2].isEnabled = false
    }
    
    //MARK: seque back to home view
    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    
}

enum ThemeEnum {
    case classic, computerized, Ensteinized
}
