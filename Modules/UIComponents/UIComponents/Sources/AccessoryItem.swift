//
//  AccessoryItem.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 04/07/2024.
//

import SwiftUI
import SFSafeSymbols
import Utilities

public struct AccessoryItem: View {
    
    public enum Style {
        case arrow
        
        public var symbol: SFSymbol {
            switch self {
            case .arrow: return .chevronLeft
            }
        }
        
        public var size: CGSize {
            switch self {
            case .arrow: return .init(width: 16.0,
                                      height: 16.0)
            }
        }
    }
    
    let style: Style
    
    public init(style: Style) {
        self.style = style
    }
    
    public var body: some View {
        Image(systemSymbol: style.symbol)
            .resizable()
            .scaledToFit()
            .frame(size: style.size)
            .flipsForRightToLeftLayoutDirection(false)
    }
}
