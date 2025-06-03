//
//  EmptyStateExampleView.swift
//  UIComponentsExampleApp
//
//  Created by Alon Zilbershtein on 26/10/2022.
//

import SwiftUI
import UIComponents

struct HorizonEmptyStateExampleComponentView: View {
    
    struct Constants {
        static let title = "Horizon Empty State"
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
                EmptyStateExampleView()
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

struct EmptyStateExampleView: View {
    
    enum ViewType {
        case basic
        case functional
    }
    
    @State var title: String = ""
    @State var subtitle: String = ""
    @State var ctaButtonTitle: String = ""
    @State var type: ViewType = .basic

    var body: some View {
        VStack(alignment: .center) {
            Text("Empty state settings")
                .horizonTypographyH3Bold()
            TextField("Enter title", text: $title)
                .multilineTextAlignment(.center)
            TextField("Enter subtitle", text: $subtitle)
                .multilineTextAlignment(.center)
            TextField("Enter button title", text: $ctaButtonTitle)
                .multilineTextAlignment(.center)
            Picker(selection: $type, label: Text("Choose type")) {
                Text("Basic type").tag(ViewType.basic)
                Text("Functional type").tag(ViewType.functional)
            }
            
            EmptyStateViewSwiftUI(type: emptyStateViewType, action: nil)
                .border(.black)
        }
    }
    
    private var emptyStateViewType: EmptyStateView.EmptyStateViewType {
        switch type {
        case .basic:
            return .basic(
                icon: UIComponentsAsset.UIComponents.logoWithBackgroundIcon.image,
                title: title,
                description: subtitle,
                ctaButtonTitle: ctaButtonTitle
            )
        case .functional:
            return .functional(
                icon: UIComponentsAsset.UIComponents.logoWithBackgroundIcon.image,
                functionalIcon: UIComponentsAssets.cancelCircleFillIcon.image,
                functionalIconTintColor: .horizonError700,
                title: title,
                description: subtitle,
                ctaButtonTitle: ctaButtonTitle.isEmpty ? nil : ctaButtonTitle
            )
        }
    }
}

struct EmptyStateExampleView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateExampleView()
    }
}
