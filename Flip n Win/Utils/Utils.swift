//
//  GameMode.swift
//  Flip n Win
//
//  Created by Mathieu Lamvohee on 11/28/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import UIKit

enum GameMode: String, CaseIterable {
    case Easy = "Easy"
    case Medium = "Medium"
    case Hard = "Hard"
    
    var value: Int {
        switch self {
        case .Easy: return 0
        case .Medium   : return 1
        case .Hard  : return 2
        }
    }
    
    static let allValues = [Easy, Medium, Hard]
    
    static var count: Int { return GameMode.allCases.count }
    
}

enum PopupStatus{
    case newGame
    case win
    case lose
}

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    let kSavedGameModeDefaultsKey = "mode"
    var gameMode: GameMode? {
        get {
            guard let gameMode = UserDefaults.standard.value(forKey: kSavedGameModeDefaultsKey) as? String else {
                return nil
            }
            return GameMode(rawValue: gameMode)
        }
        set(mode) {
            UserDefaults.standard.set(mode?.rawValue, forKey: kSavedGameModeDefaultsKey)
        }
    }
    
    var highscore: [Int]? {
        get {
            guard let mode = gameMode,
            let highscore = UserDefaults.standard.value(forKey: mode.rawValue) as? [Int]
            else {
                return nil
            }
            return highscore
        }
        set(highscore) {
            guard let mode = gameMode else{return}
            UserDefaults.standard.set(highscore, forKey: mode.rawValue)
        }
    }
}
