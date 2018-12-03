//
//  ViewController.swift
//  Flip'n Win
//
//  Created by Mathieu Lamvohee on 11/22/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var gameModeView: UIView!
    @IBOutlet weak var gameModeLabel: UILabel!
    @IBOutlet weak var bestScoreView: UIView!
    @IBOutlet weak var bestScoreLabel: UILabel!
    
    var picker = UIPickerView()
    let toolbar = UIToolbar()
    var currentSelectedIndex = 0
    let DEFAUL_GAME_MODE = "Easy"
    var isHighscoreButtonEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set default game mode
        gameModeLabel.text = DEFAUL_GAME_MODE
        UserDefaultsManager.shared.gameMode = GameMode(rawValue: DEFAUL_GAME_MODE)
        
        //set highscore label
        setHighscoreLabel()
        
        playButton.layer.cornerRadius = 5
        gameModeView.layer.cornerRadius = 5
        bestScoreView.layer.cornerRadius = 5
        
        createPickerView()
        createToolbar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //set highscore label
        setHighscoreLabel()
    }
    
    @IBAction func modeButtonClicked(_ sender: CustomPickerButton) {
        picker.selectRow(currentSelectedIndex, inComponent: 0, animated: false)
        sender.inputAccessoryView = toolbar
        sender.inputView = picker
    }
    
    @objc func doneTapped() {
        //Save the Game Mode in the userdefaults
        guard let gameMode = gameModeLabel.text else {return}
        UserDefaultsManager.shared.gameMode = GameMode(rawValue: gameMode)
        setHighscoreLabel()
        self.view.endEditing(true)
    }
    
    @IBAction func playButtonClicked(_ sender: Any) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showGame", sender: nil)
        }
    }
    
    @IBAction func highscoreButtonClicked(_ sender: Any) {
        DispatchQueue.main.async {
            if self.isHighscoreButtonEnabled {
                self.performSegue(withIdentifier: "showHighscores", sender: nil)
            }
            
        }
    }
    
    //MARK: - Methods
    func setHighscoreLabel() {
        if let score = UserDefaultsManager.shared.highscore {
            isHighscoreButtonEnabled = score.count > 1 ? true : false
            bestScoreLabel.text = String(format: "%d points", score[0])
        } else {
            bestScoreLabel.text = "--"
        }
    }
    
    //MARK: Picker View setup
    func createPickerView()
    {
        picker.delegate = self
        picker.delegate?.pickerView?(picker, didSelectRow: 0, inComponent: 0)
        picker.backgroundColor = UIColor(red: 55/255, green: 55/255, blue: 105/255, alpha: 255/255)
    }
    
    func createToolbar() {
        picker.delegate = self
        toolbar.sizeToFit()
        toolbar.barTintColor = UIColor(red: 55/255, green: 55/255, blue: 105/255, alpha: 255/255)
        toolbar.tintColor = UIColor(red: 221/255, green: 147/255, blue: 74/255, alpha: 255/255)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
    }
    
    //MARK: Picker Data Source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GameMode.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        gameModeLabel.text = GameMode.allValues[row].rawValue
        currentSelectedIndex = row
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = GameMode.allValues[row].rawValue
        return NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
}

