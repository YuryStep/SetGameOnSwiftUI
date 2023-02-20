//
//  CardView.swift
//  SetCardGame
//
//  Created by Юрий Степанчук on 16.02.2023.
//

import SwiftUI

struct CardView: View {
    var card: ClassicSetGame.Card
    
    var colorOfCard: Color {
        switch card.color {
        case .green : return .green
        case .red : return .red
        case .purple : return .purple
        }
    }
    var opacityOfCard: Double {
        switch card.shading {
        case .solid : return 1
        case .striped : return 0.2
        case .open : return 0
        }
    }
    @ViewBuilder
    var CardSymbol: some View {
        switch card.symbol {
        case .diamond : ZStack {
            Squiggle().opacity(opacityOfCard)
            Squiggle().stroke(lineWidth: 2)
        }
        case .squiggle : ZStack {
            Dimond().opacity(opacityOfCard)
            Dimond().stroke(lineWidth: 2)
        }
        case .oval : ZStack {
            Capsule().opacity(opacityOfCard)
            Capsule().stroke(lineWidth: 2)
        }
        }
    }
    
    var baseColor: Color {
        if let matchingStatus = card.isMatched {
            return matchingStatus ? .green.opacity(0.2) : .red.opacity(0.2)
        }
        return card.isSelected ? .yellow.opacity(0.5) : .gray.opacity(0.1)
    }
          
    
    var body: some View {
        let shape = CardSymbol.foregroundColor(colorOfCard)
            .aspectRatio(DrawingConstants.symbolAspectRatio, contentMode: .fit)
        
        ZStack {
            RoundedRectangle(cornerRadius: DrawingConstants.cornerRadiusOfCard)
                .foregroundColor(baseColor)
            
            RoundedRectangle(cornerRadius: DrawingConstants.cornerRadiusOfCard)
                .strokeBorder(lineWidth: DrawingConstants.defaultLineWidthOfCard)
            VStack {
                if card.value == 1 {
                    shape
                } else if card.value == 2 {
                    shape
                    shape
                } else {
                    shape
                    shape
                    shape
                }
            }
            .padding(20)
        }
    }
    
    private struct DrawingConstants {
        static let cornerRadiusOfCard: CGFloat = 15
        static let defaultLineWidthOfCard: CGFloat = 1
        static let symbolAspectRatio = CGSize(width: 2, height: 1)
    }
    
}
    

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
