//
//  ClassicSetGame.swift
//  SetCardGame
//
//  Created by Юрий Степанчук on 13.02.2023.
//
// MARK: ViewModel
//

import SwiftUI

class ClassicSetGame: ObservableObject {
    
    enum Symbol: CaseIterable {
        case diamond, squiggle, oval
    }
    enum Shading: CaseIterable {
        case solid, striped, open
    }
    enum SymbolColor: CaseIterable {
        case red, green, purple
    }
    enum Value: Int, CaseIterable {
        case one = 1, two, three
    }
    
    typealias Card = SetGame<Symbol, Shading, SymbolColor>.Card
    
    private static func createDeck() -> [Card] {
        var classicDeckOfCards = [Card]()
        var id = 0
        for symbol in Symbol.allCases {
            for shading in Shading.allCases {
                for color in SymbolColor.allCases {
                    for value in Value.allCases {
                        classicDeckOfCards.append(Card(symbol: symbol,
                                                       shading: shading,
                                                       color: color,
                                                       value: value.rawValue,
                                                       id: id))
                        id += 1
                    }
                }
            }
        }
        return classicDeckOfCards
    }
    
    private static func createNewGame() -> SetGame<Symbol, Shading, SymbolColor> {
        var newGame = SetGame(cards: ClassicSetGame.createDeck().shuffled())
        for index in 0..<12 {
            newGame.cards[index].inGame = true
        }
        return newGame
    }
    
    @Published private var model = createNewGame()
    var deck: [Card] { model.cards }
    var score: Int {model.gameScore}
    
    // MARK: User's Intent(s)
    func choose(_ selectedCard: Card) {
        model.choose(selectedCard)
    }
    
    func addMoreCards() {
        model.addMoreCards()
    }
    
    func startNewGame() {
        model = ClassicSetGame.createNewGame()
    }
    
}
