//
//  ViewController.swift
//  Memorization Exercise Game
//
//  Created by Kien Phan on 1/5/18.
//  Copyright © 2018 Kien Phan. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {
    
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet var nineButtons: [RoundEdgeButtons]!
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var removeAdsButton: UIButton!
    @IBOutlet weak var ThemeImageView: UIImageView!
    
    //MARK: init needed objects
    let soundHandler = SoundHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        sortButtonsTags() //MIGHT NOT NEED
        createNewGame() //start the game
        
        scoreLabel.isHidden = true //hide score label
        
        if let highscore = UserDefaults.standard.value(forKey: "highscore") as? Int{ //check if there is highscore in memory
            self.highscore = highscore //set highscore to the one in memory and show it
            highscoreLabel.text = "Highscore : \(highscore)"
            HighscoreHandler.highscore = highscore //testing
        }
    
    }

    override func viewDidAppear(_ animated: Bool) {
        let save  = UserDefaults.standard // for removeads purchase
        if save.value(forKey: "purchased") == nil { // If there is nothing in purchased key in memory then the user had not purchased the removeads so display the ads
            admobRequest() //request admob ads
        } else { // if purchased had something in it then it mean our user had purchased removeads !!!!
            bannerView.isHidden = true
            removeAdsButton.isHidden = true
        }
        
        SelectedTheme.loadSavedSelectedTheme() //load in selected theme
        themeAndSoundSelection()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameEnded { // this only works if the game has ended
            gameEnded = false // so it doesnt execute twice
            createNewGame()
            updateScore()
            scoreLabel.isHidden = true //hide score label
        }
    }
    
    //MARK: Game Functionality
    var flashingButton = 0
    var score = 0
    var highscore = 0
    
    var sequenceIndex = 0
    var questionSequence = [Int]() //store the question sequence
    var answerSequence = [Int]() //temporary store the question sequence and remove if the user tap on the correct answer
    
    var gameEnded = false
    
    func createNewGame() {
        questionSequence.removeAll()
        
        actionButton.setTitle("Start Challenge", for: .normal)
        actionButton.isEnabled = true //make sure the button is on when we need to start a new level
        for button in nineButtons {
            button.isEnabled = false
            button.alpha = 0.5
        }
        
        score = 0
    }
    
    func updateScore() {
        scoreLabel.text = "score : \(score)"
    }
    
    func updateHighScore() {
        highscore = score
        saveHighscore(num: highscore)
        highscoreLabel.text = "Highscore : \(highscore)"
        HighscoreHandler.highscore = highscore //testing

    }
    
    func addNewStep() {
        questionSequence.append(Int(arc4random_uniform(UInt32(6)))) //add a random number to questionSequence array
    }
    
    func flashAskSequence() {
        if sequenceIndex < questionSequence.count { //check if our sequence index is less than questionSequence.count so it doesnt crash and also show that the level is complete
            flashingButton = questionSequence[sequenceIndex] // set the flashingbutton to the button that is about to be flash so that we know what sound to play
            flash(button: nineButtons[questionSequence[sequenceIndex]])
            sequenceIndex += 1 // increase the sequence index so that the next round will contain another step
        } else {
            answerSequence = questionSequence // make a copy of question sequence
            view.isUserInteractionEnabled = true // enable the user to tap on the nine buttons
            actionButton.setTitle("Tap the Boxes", for: .normal) // use the actionButton as a reminder for the player to tap
            for button in nineButtons {
                button.isEnabled = true // reenable the ninebuttons
            }
        }
    }

    func flash(button: RoundEdgeButtons) { // this will recieve a button out of the nine RoundEdgeButtons and flashes it
        UIView.animate(withDuration: 0.35, animations: {
            button.alpha = 1.0
            self.soundHandler.play(resource: "\(self.themeSound)\(self.flashingButton)", type: "wav")
            button.alpha = 0.5
        }) { (bool) in
            self.flashAskSequence() // this will either flash another button is there is more things in the askSequence or let the player tap on the ninebuttons
        }
    }
    
    func endGame() {
        soundHandler.play(resource: "note666", type: "wav")
        actionButton.setTitle("Gameover", for: .normal)
        gameEnded = true
        
    }
    
    //MARK: Button tapped handlers
    @IBAction func nineButtonsTapped(_ sender: RoundEdgeButtons) {
        if sender.tag == answerSequence.removeFirst() { // check if the button tap is equal the the correct color for the first entry of answerSequence if so remove the first entry making the next entry first!
            self.soundHandler.play(resource: "\(themeSound)\(sender.tag)", type: "wav") //make sure the right sound play at the right button
        } else { // if the user tapped on the wrong button
            for button in nineButtons { //disable the buttons
                button.isEnabled = false
            }
            endGame()
            return // leave the function and not execute the code below!
        }
        //if the user pass the first if else statment then they have completed the questioinSequence correctly
        if  answerSequence.isEmpty {
            for button in nineButtons {
                button.isEnabled = false
            }
            score += 1
            updateScore()
            if score > highscore { updateHighScore() }
            actionButton.setTitle("next level", for: .normal)
            actionButton.isEnabled = true
        }
        
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        scoreLabel.isHidden = false // show score label
        
        sequenceIndex = 0 //reset the index so that the sequence starts from the beginning
        actionButton.setTitle("Remember this!", for: .normal)
        actionButton.isEnabled = false // make sure the user cant start new game durring playing time
        view.isUserInteractionEnabled = false // this will stop the user from tapping any of the nine buttons or any UI Elements when the askSequence is playing
        addNewStep() //add a new step for the player to remember
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.flashAskSequence()
        }
    }

    //MARK: Save highscore function
    func saveHighscore(num: Int) {
        UserDefaults.standard.set(num, forKey: "highscore")
    }
    
    //MARK: extra Fuctions
    func sortButtonsTags() {    //sort out the button tag ??? MIGHT NOT NEED
        nineButtons = nineButtons.sorted(){
            $0.tag < $1.tag
        }
    }
    
    
    //MARK: Functions and variables that handles theme and sound selection
    let themeAndSound = ThemeAndSoundBank() // Theme and sounds
    var themeColor = [UIColor]()
    var themeSound = "note"
    var themeImage = "einsteinize"
    func themeAndSoundSelection(){

        switch SelectedTheme.selectedTheme {
        case .classic:
            changeTheme(themeNum: 0)
        case .computerized:
            changeTheme(themeNum: 1)
        case .Ensteinized:
            changeTheme(themeNum: 2)
        }
    }
    
    func changeTheme(themeNum: Int) { 
        themeColor = themeAndSound.themesArray[themeNum].buttonsColors
        themeSound = themeAndSound.themesArray[themeNum].buttonsSound
        themeImage = themeAndSound.themesArray[themeNum].themeImage
        print("ThemeSound = \(themeSound)")
        print("themeImage = \(themeImage)")
        changeButtonsColor()
        changeThemeImage(themeNum: themeNum)
    }
    
    func changeButtonsColor() {
        for button in nineButtons {
            button.backgroundColor = themeColor[button.tag]
            gameView.backgroundColor = themeColor[6]
        }
    }
    
    func changeThemeImage(themeNum: Int) { //make sure that when the user select classic theme no image is shown for the theme
        if themeNum > 0 {
            ThemeImageView.image = UIImage(named: themeImage + ".jpg") //load in the image using its name get from themeImage
        } else {
            ThemeImageView.image = nil
        }
    }
    
    //MARK: Share app
    @IBOutlet weak var shareButtonOutlet: UIButton!
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        let activityVC = UIActivityViewController(activityItems: ["Hey bet you can't beat my highscore: \(highscore)! on Memoriize https://itunes.apple.com/us/app/memoriize/id1333621300?ls=1&mt=8"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC,animated: true, completion: nil)
    }
    
    
    //MARK: ADMOB Stuff
    @IBOutlet weak var bannerView: GADBannerView!
    
    func admobRequest() {
        let request = GADRequest()
        //request.testDevices = [kGADSimulatorID] // if testing on simulator
        
        bannerView.adUnitID = "ca-app-pub-1015328592174437/6894600124" //Get this AD Unit ID from ADMOB
        bannerView.rootViewController = self
        bannerView.load(request)
    }
    
    

}

//MARK: EXTRA CODE THAT WE DONT NEED

//override func didReceiveMemoryWarning() {
//    super.didReceiveMemoryWarning()
//    // Dispose of any resources that can be recreated.
//}

