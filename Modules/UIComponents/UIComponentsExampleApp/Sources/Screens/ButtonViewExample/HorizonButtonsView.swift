//
//  HorizonButtonsView.swift
//  UIComponents
//
//  Created by Alon Zilbershtein on 14/07/2022.
//

import SwiftUI
import UIComponents

struct HorizonButtonsComponentsView: View {
    
    struct Constants {
        static let title = "Horizon Buttons"
        static let doneButton = "Done"
    }
    
    @State var showView: Bool = false
    var body: some View {
        Button(Constants.title) {
            self.showView = true
        }
        .frame(maxWidth: .infinity,
               alignment: .center)
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $showView) {
            NavigationView {
                HorizonButtonsView()
                    .navigationBarTitle(Text(Constants.title),
                                        displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {
                        self.showView = false
                    }) {
                        Text(Constants.doneButton)
                            .bold()
                            .foregroundColor(.horizonPrimary)
                    })
            }
        }
    }
}

struct HorizonButtonsView: View {
    
    @State var showDisabled: Bool = false
    @State var showStretched: Bool = false
    @State var showWithIcon: Bool = false

    enum ButtonsForExampleApp: String, CaseIterable {
        case primaryLarge = "Primary Large"
        case primaryMedium = "Primary Medium"
        case secondaryLarge = "Secondary Large"
        case secondaryMedium = "Secondary Medium"
        case secondarySmall = "Secondary Small"
        case tertiaryLarge = "Tertiary Large"
        case tertiaryMedium = "Tertiary Medium"
        case tertiarySmall = "Tertiary Small"
        case linkLarge = "Link Large"
        case linkMedium = "Link Medium"
        case linkSmall = "Link Small"
        case linkXs = "Link Extra Small"
        case specialLarge = "Special Large"
        case specialMedium = "Special Medium"
        
        var kind: HorizonButton.Kind {
            switch self {
            case .primaryLarge, .primaryMedium:
                return .primary
            case .secondaryLarge, .secondaryMedium, .secondarySmall:
                return .secondary
            case .tertiaryLarge, .tertiaryMedium, .tertiarySmall:
                return .link(titleColor: .orange)
            case .linkLarge, .linkMedium, .linkSmall, .linkXs:
                return .link()
            case .specialLarge, .specialMedium:
                return .special(backgroundColor: UIColor.horizonError500,
                                titleColor: UIColor.horizonNeutral900)
            }
        }
        
        var dimension: HorizonButton.Dimension {
            switch self {
            case .primaryLarge, .secondaryLarge, .tertiaryLarge, .linkLarge, .specialLarge:
                return .large
            case .primaryMedium, .secondaryMedium, .tertiaryMedium, .linkMedium, .specialMedium:
                return .medium
            case .secondarySmall, .tertiarySmall, .linkSmall:
                return .small
            case .linkXs:
                return .xsmall
            }
        }
    }
    
    var body: some View {
        Toggle(isOn: $showDisabled) {
            Text("Show disabled")
        }.padding()
        Toggle(isOn: $showStretched) {
            Text("Show strcetched")
        }.padding()
        Toggle(isOn: $showWithIcon) {
            Text("Show with icon")
        }.padding()
        Form {
            ForEach(ButtonsForExampleApp.allCases, id: \.self) { button in
                HorizonButtonView(kind: button.kind,
                                  dimension: button.dimension,
                                  text: button.rawValue,
                                  icon: showWithIcon ? IconConfiguration(image: UIComponentsAssets.menuIcon.image, edge: .trailing) : nil,
                                  appearance: showStretched ? .stretched : .fixed,
                                  action: {print("Pressed")}
                )
                .frame(maxWidth: .infinity)
                .disabled(showDisabled)
            }
        }
    }
}

struct HorizonButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        HorizonButtonsView()
    }
}
