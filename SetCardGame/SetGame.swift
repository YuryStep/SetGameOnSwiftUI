//
//  SetGame.swift
//  SetCardGame
//
//  Created by Юрий Степанчук on 13.02.2023.
//

// Model
// This model implementation not only UIIndependent, but also doesn't provide any information about symbols,shading style and colors.
// It's purpose onlu logic and original data storage (sourth of Truth)

import Foundation

struct SetGame<Symbol: Equatable, Shading: Equatable, SymbolColor: Equatable> {
    var cards: [Card]
    private (set) var gameScore = 0
    private var selectedCards: [Card] { cards.filter { $0.isSelected } }
    private var setCheckIsSuccessfull: Bool {
        if selectedCards.count == 3 {
            let card1 = selectedCards[0]
            let card2 = selectedCards[1]
            let card3 = selectedCards[2]
            if card1.symbol == card2.symbol &&
                card1.symbol == card3.symbol ||
                card1.symbol != card2.symbol &&
                card1.symbol != card3.symbol &&
                card2.symbol != card3.symbol {
                if card1.color == card2.color &&
                    card1.color == card3.color ||
                    card1.color != card2.color &&
                    card1.color != card3.color &&
                    card2.color != card3.color {
                    if card1.shading == card2.shading &&
                        card1.shading == card3.shading ||
                        card1.shading != card2.shading &&
                        card1.shading != card3.shading &&
                        card2.shading != card3.shading {
                        if card1.value == card2.value &&
                            card1.value == card3.value ||
                            card1.value != card2.value &&
                            card1.value != card3.value &&
                            card2.value != card3.value {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    
    private mutating func cleanSelection() {
        for index in cards.indices { cards[index].isSelected = false }
    }
    
    mutating func choose(_ card: Card) {
        if let indexOfChosenCard = cards.firstIndex(where: { $0.id == card.id}) {
            if selectedCards.count <= 2 {
                cards[indexOfChosenCard].isSelected.toggle()
                if selectedCards.count == 3 {
                    for index in cards.indices {
                        if cards[index].isSelected {
                            cards[index].isMatched = setCheckIsSuccessfull
                        }
                    }
                }
            } else {
                if setCheckIsSuccessfull {
                    for index in cards.indices {
                        if cards[index].isSelected {
                            cards[index].inGame = false
                        }
                    }
                    addMoreCards()
                } else {
                    for index in cards.indices {
                        if cards[index].isSelected {
                            cards[index].isMatched = nil
                        }
                    }
                }
                cleanSelection()
                if cards[indexOfChosenCard].isMatched != true {
                    cards[indexOfChosenCard].isSelected.toggle()
                }
            }
        }
    }
    
    mutating func addMoreCards() {
        if setCheckIsSuccessfull {
            for index in cards.indices {
                if cards[index].isSelected {
                    cards[index].inGame = false
                }
            }
            cleanSelection()
            gameScore += 1
        }
        for _ in 0..<3 {
            if let index = cards.firstIndex(where: {!$0.inGame && $0.isMatched == nil}) {
                cards[index].inGame = true
            }
        }
    }
    
    struct Card: Identifiable {
        let symbol: Symbol
        let shading: Shading
        let color: SymbolColor
        let value: Int
        
        var inGame = false
        var isSelected = false
        var isMatched: Bool?
        
        let id: Int
    }
}
