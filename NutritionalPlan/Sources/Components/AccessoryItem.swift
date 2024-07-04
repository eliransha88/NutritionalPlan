//
//  AccessoryItem.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftUI
import SFSafeSymbols

struct AccessoryItem: View {
    
    enum Style {
        case arrow
        
        var symbol: SFSymbol {
            switch self {
            case .arrow: return .chevronLeft
            }
        }
        
        var size: CGSize {
            switch self {
            case .arrow: return .init(width: 16.0,
                                      height: 16.0)
            }
        }
    }
    
    let style: Style
    
    var body: some View {
        Image(systemSymbol: style.symbol)
            .resizable()
            .scaledToFit()
            .frame(size: style.size)
            .flipsForRightToLeftLayoutDirection(false)
    }
}
