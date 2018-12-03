//
//  UnsplashPhotoApiService.swift
//  Flip'n Win
//
//  Created by Mathieu Lamvohee on 11/27/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import Foundation


class UnsplashPhotoApiService {
    static func getPhotosList(url: String,
                                 success: @escaping ((_ result: [PhotoModel]) -> ()),
                                 failure: @escaping (Error?) -> ()) {
        
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {return}
            
            do {
                let photoList = try JSONDecoder().decode([PhotoModel].self, from: data)
                success(photoList)
            } catch let jsonError {
                print("Error serializing json: ", jsonError)
            }
            }.resume()
    }
}
