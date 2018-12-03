//
//  UnsplashPhotoModel.swift
//  Flip'n Win
//
//  Created by Mathieu Lamvohee on 11/27/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import Foundation

struct UnsplashPhotoModel: Codable {
    var photoList: [PhotoModel]?

    
    init(photoList:[PhotoModel]?) {
        self.photoList = photoList
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let list = try container.decodeIfPresent([PhotoModel].self)
        self.init(photoList: list)
    }
    
}

struct PhotoModel: Codable {
    var urls: URLPhotoModel?
    
    init(urls: URLPhotoModel?) {
        self.urls = urls
    }
    
    enum PhotoModelKeys: String, CodingKey {
        case urls = "urls"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PhotoModelKeys.self)
        let urls = try container.decodeIfPresent(URLPhotoModel.self, forKey: .urls)
        self.init(urls: urls)
    }
}

struct URLPhotoModel: Codable {
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?
    
    enum URLPhotoModelKeys: String, CodingKey {
        case raw = "raw"
        case full = "full"
        case regular = "regular"
        case small = "small"
        case thumb = "thumb"
    }
    
    init(raw: String?, full: String?, regular: String?, small: String?, thumb: String?) {
        self.raw = raw
        self.full = full
        self.regular = regular
        self.small = small
        self.thumb = thumb
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: URLPhotoModelKeys.self)
        let raw = try container.decodeIfPresent(String.self, forKey: .raw)
        let full = try container.decodeIfPresent(String.self, forKey: .full)
        let regular = try container.decodeIfPresent(String.self, forKey: .regular)
        let small = try container.decodeIfPresent(String.self, forKey: .small)
        let thumb = try container.decodeIfPresent(String.self, forKey: .thumb)
    
        self.init(raw: raw, full: full, regular: regular, small: small, thumb: thumb)
    }
    
}
