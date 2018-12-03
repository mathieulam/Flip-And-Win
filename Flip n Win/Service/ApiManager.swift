//
//  ApiManager.swift
//  Flip'n Win
//
//  Created by Mathieu Lamvohee on 11/27/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import Foundation

class ApiManager {
    
    static let shared = ApiManager()
    
    private init(){
        
    }
    
    func getPhotos(gameMode: GameMode, success: @escaping ([PhotoModel]) -> (),
                   failure: @escaping (Error?) -> ()) {
        var itemCount = 0
        switch gameMode {
        case .Easy:
            itemCount = 6
        case .Medium:
            itemCount = 8
        case .Hard:
            itemCount = 10
        }
        
        let url = UNSPLAH_URL_API + "?client_id=\(UNSPLAH_ACCESS_KEY)&" + "?page=1&query=cats&count=\(itemCount)"
        
        UnsplashPhotoApiService.getPhotosList(url: url, success: success, failure: failure)
    }
}
