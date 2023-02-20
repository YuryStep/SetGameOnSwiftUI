//
//  SetGameView.swift
//  SetCardGame
//
//  Created by Юрий Степанчук on 13.02.2023.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var viewModel: ClassicSetGame
    
    var body: some View {
        let cardsInGame = viewModel.deck.filter { $0.inGame }
        VStack {
            HStack {
                Button("New Game") { viewModel.startNewGame() }
                Spacer()
                Text("Score: \(viewModel.score)")
                Spacer()
                Button("More Cards") { viewModel.addMoreCards() }
                    .disabled(viewModel.deck.filter({!$0.inGame && $0.isMatched == nil}).count > 0 ? false : true)
            }
            .padding(.horizontal)
            .fontWeight(.heavy)
            
            AspectVGrid(items: cardsInGame, aspectRatio: 2/3) { card in
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .padding(.horizontal)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = ClassicSetGame()
        SetGameView(viewModel: game)
    }
}
