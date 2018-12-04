//
//  UnsplashPhotoModelTest.swift
//  Flip n WinTests
//
//  Created by Mathieu Lamvohee on 12/4/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import XCTest

class UnsplashPhotoModelTest: XCTestCase {

    let API_URL = "https://api.unsplash.com/photos/random?client_id=52dc6e432be0a2d872a81f7e77392f92548d77d3c572c13f90597d8ecde23a32&?page=1&query=cats&count=6%20-%20_url%20:%20https://api.unsplash.com/photos/random?client_id=52dc6e432be0a2d872a81f7e77392f92548d77d3c572c13f90597d8ecde23a32&?page=1&query=cats&count=6"
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testUnsplashPhotoModelMapsData() throws {
        guard let url = URL(string: API_URL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                
                let unsplashPhotoModel = try JSONDecoder().decode(UnsplashPhotoModel.self, from: data)
                
                XCTAssertNotNil(unsplashPhotoModel)
                XCTAssertNotNil(unsplashPhotoModel.photoList)
                
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
    
    func testPhotoModelMapsData() throws {
        guard let url = URL(string: API_URL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                
                let unsplashPhotoModel = try JSONDecoder().decode(UnsplashPhotoModel.self, from: data)
                
                XCTAssertNotNil(unsplashPhotoModel)
                XCTAssertNotNil(unsplashPhotoModel.photoList)
                XCTAssertNotNil(unsplashPhotoModel.photoList![0].urls)
                
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
    
    func testURLPhotoModelMapsData() throws {
        guard let url = URL(string: API_URL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                
                let unsplashPhotoModel = try JSONDecoder().decode(UnsplashPhotoModel.self, from: data)
                
                XCTAssertNotNil(unsplashPhotoModel)
                XCTAssertNotNil(unsplashPhotoModel.photoList)
                XCTAssertNotNil(unsplashPhotoModel.photoList![0].urls)
                XCTAssertNotNil(unsplashPhotoModel.photoList![0].urls!.thumb)
                
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }

}
