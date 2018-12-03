//
//  UIImage+Downloader.swift
//  Flip n Win
//
//  Created by Mathieu Lamvohee on 11/27/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
        self.init(data: imageData)
    }
    
}
