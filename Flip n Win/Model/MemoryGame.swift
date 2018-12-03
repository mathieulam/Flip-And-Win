//
//  MemoryGame.swift
//  Flip n Win
//
//  Created by Mathieu Lamvohee on 11/29/18.
//  Copyright © 2018 Mathieu Lamvohee. All rights reserved.
//

import Foundation
import UIKit


// MARK: - MemoryGameDelegate

protocol MemoryGameDelegate {
    func memoryGameDidStart(game: MemoryGame)
    func memoryGame(game: MemoryGame, showCards cards: [Card])
    func memoryGame(game: MemoryGame, hideCards cards: [Card])
    func memoryGameDidEnd(game: MemoryGame)
}

// MARK: - MemoryGame

class MemoryGame {
    
    // MARK: - Properties
    
    var cards:[Card] = [Card]()
    var delegate: MemoryGameDelegate?
    var isPlaying: Bool = false
    
    private var cardsShown:[Card] = [Card]()
    private var startTime:NSDate?
    
    var numberOfCards: Int {
        get {
            return cards.count
        }
    }
    
    // MARK: - Methods
    
    func newGame(cardsData:[UIImage]) {
        cards = randomCards(cardsData: cardsData)
        isPlaying = true
        delegate?.memoryGameDidStart(game: self)
    }
    
    func stopGame() {
        isPlaying = false
        cards.removeAll()
        cardsShown.removeAll()
    }
    
    func didSelectCard(card: Card?) {
        guard let card = card else { return }
        
        delegate?.memoryGame(game: self, showCards: [card])
        
        if unpairedCardShown() {
            let unpaired = unpairedCard()!
            if card.equals(card: unpaired) {
                cardsShown.append(card)
            } else {
                let unpairedCard = cardsShown.removeLast()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.delegate?.memoryGame(game: self, hideCards: [card, unpairedCard])
                }
            }
        } else {
            cardsShown.append(card)
        }
        
        if cardsShown.count == cards.count {
            finishGame()
        }
    }
    
    func cardAtIndex(index: Int) -> Card? {
        if cards.count > index {
            return cards[index]
        } else {
            return nil
        }
    }
    
    func indexForCard(card: Card) -> Int? {
        for index in 0...cards.count-1 {
            if card === cards[index] {
                return index
            }
        }
        return nil
    }
    
    private func finishGame() {
        isPlaying = false
        delegate?.memoryGameDidEnd(game: self)
    }
    
    private func unpairedCardShown() -> Bool {
        return cardsShown.count % 2 != 0
    }
    
    private func unpairedCard() -> Card? {
        let unpairedCard = cardsShown.last
        return unpairedCard
    }
    
    private func randomCards(cardsData:[UIImage]) -> [Card] {
        var cards = [Card]()
        for i in 0...cardsData.count-1 {
            let card = Card.init(image: cardsData[i])
            cards.append(contentsOf: [card, Card.init(card: card)])
        }
        cards.shuffle()
        return cards
    }
    
}
