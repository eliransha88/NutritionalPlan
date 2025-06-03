//
//  UIComponentsExampleAppRootView.swift
//  UIComponentsExampleApp
//
//  Created by Itamar Manor on 25/01/2024.
//

import SwiftUI

struct UIComponentsExampleAppRootView: View {
    
    private struct ExampleScreen {
        let title: String
        let viewCreator: () -> AnyView
    }
    
    private let examples: [ExampleScreen] = [
        ExampleScreen(title: "Button View") { AnyView(HorizonButtonsView()) },
        ExampleScreen(title: "Loading View") { AnyView(LoadingViewExampleView()) },
        ExampleScreen(title: "Notification Banner") { AnyView(NotificationBannerExampleView()) },
        ExampleScreen(title: "Empty State View") { AnyView(EmptyStateExampleView()) },
        ExampleScreen(title: "Modal View") { AnyView(ModalViewExampleView()) },
        ExampleScreen(title: "Horizon Color Catalog") { AnyView(HorizonColorsView()) },
        ExampleScreen(title: "Horizon Gradient Catalog") { AnyView(HorizonGradientsView()) },
        ExampleScreen(title: "Horizon Typography Catalog") { AnyView(HorizonTypographyView()) },
        ExampleScreen(title: "Horizon Badge") { AnyView(BadgeViewExample()) }
    ]
    
    var body: some View {
        List(examples, id: \.title) { example in
            NavigationLink(example.title, destination: example.viewCreator())
        }
        .navigationBarTitle("Example List", displayMode: .inline)
        .listStyle(.grouped)
    }
}

#Preview {
    UIComponentsExampleAppRootView()
}
