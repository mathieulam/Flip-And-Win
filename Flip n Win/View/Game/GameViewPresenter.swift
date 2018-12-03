//
//  StartViewPresenter.swift
//  Flip n Win
//
//  Created by Mathieu Lamvohee on 11/27/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import Foundation
import UIKit

protocol GameViewProtocol: class {
    func refreshData()
}

class GameViewPresenter: NSObject {
    weak var view: GameViewProtocol?
    private var photoList: [PhotoModel]?
    private var gameMode: GameMode = GameMode.Easy
    
    init(gameView: GameViewProtocol) {
        super.init()
        self.view = gameView
        
        if let mode = UserDefaultsManager.shared.gameMode {
            gameMode = mode
        }
        
    }
    
    
    func getPhotos() {
        ApiManager.shared.getPhotos(gameMode: getGameMode(),success: { (result) in
            self.photoList = result
            self.view?.refreshData()
        }) { (error) in
            print(error.debugDescription)
        }
    }
    
    func getPhotoList() -> [UIImage] {
        var imageArray = [UIImage]()
        guard let photoList = self.photoList else {fatalError()}
        
        for photo in photoList {
            guard
                let urls = photo.urls,
                let thumb = urls.thumb
            else {fatalError()}
            
            let imageUrl = URL(string: thumb)!
            
            guard let image = try? UIImage(withContentsOfUrl: imageUrl) else {fatalError()}
            
            imageArray.append(image!)
            
        }
        
        return imageArray
    }
    
    func getTimerSeconds() -> Int {
        switch self.gameMode {
        case .Easy:
            return 60
        case .Medium:
            return 45
        case .Hard:
            return 30
        }
    }
    
    func getGameMode() -> GameMode {
        return self.gameMode
    }
}
