//
//  MemoryGameTest.swift
//  Flip n WinTests
//
//  Created by Mathieu Lamvohee on 12/4/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import XCTest
@testable import Flip_n_Win

class MemoryGameTest: XCTestCase, MemoryGameDelegate {
    
    var gameUnderTest: MemoryGame!
    
    override func setUp() {
        super.setUp()
        
        guard let image1 = UIImage(named: "AppIcon") else {return}
        guard let image2 = UIImage(named: "AppIcon") else {return}
        guard let image3 = UIImage(named: "AppIcon") else {return}
        guard let image4 = UIImage(named: "AppIcon") else {return}
        guard let image5 = UIImage(named: "AppIcon") else {return}
        guard let image6 = UIImage(named: "AppIcon") else {return}
        gameUnderTest = MemoryGame()
        gameUnderTest.delegate = self
        gameUnderTest.newGame(cardsData: [image1, image2, image3, image4, image5, image6])
    }

    override func tearDown() {
        gameUnderTest = nil
        super.tearDown()
    }
    
    func testCardsCount() {
        let count = gameUnderTest.cards.count
        XCTAssertTrue(count == 12)
        
    }
    
    func testCardsIsHidden(){
        let cards = gameUnderTest.cards
        for card in cards {
            let shown = card.shown
            XCTAssertFalse(shown)
        }
    }
    
    func testCardsIsShown(){
        let cards = gameUnderTest.cards
        for card in cards {
            gameUnderTest.didSelectCard(card: card)
            let shown = card.shown
            XCTAssertTrue(shown)
        }
    }
    
    func memoryGame(game: MemoryGame, showCards cards: [Card]) {
        for card in cards {
            card.shown = true
        }
    }
    
    func memoryGameDidStart(game: MemoryGame) {
        
    }
    
    func memoryGame(game: MemoryGame, hideCards cards: [Card]) {
        
    }
    
    func memoryGameDidEnd(game: MemoryGame) {
        
    }
    
    func showPointView() {
        
    }

}
