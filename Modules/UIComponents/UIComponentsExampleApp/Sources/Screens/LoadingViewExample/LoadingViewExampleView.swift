//
//  LoadingViewExampleView.swift
//  UIComponents_Example
//
//  Created by Gal Orlanczyk on 17/11/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import SwiftUI
import UIComponents

struct LoadingViewExampleView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isAnimating: Bool = true
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Button("Dismiss") {
                    presentationMode.wrappedValue.dismiss()
                }.padding()
                Toggle(isOn: $isAnimating.animation()) {
                    Text("Animation:")
                }
                Divider().padding()
                LoadingViewExampleDefaultSizeView(isAnimating: $isAnimating)
                LoadingViewExampleMaxDefaultSizeView(isAnimating: $isAnimating)
                LoadingViewExampleCustomSizeView(isAnimating: $isAnimating)
                LoadingViewInsideButtonView()
                Spacer()
            }
            Spacer()
        }.padding()
    }
}

struct LoadingViewExampleDefaultSizeView: View {
    
    @Binding var isAnimating: Bool
    
    var body: some View {
        Text("default size loading view")
        LoadingViewSwiftUI(isAnimating: isAnimating)
            .defaultSize()
        Divider().padding()
    }
}

struct LoadingViewExampleMaxDefaultSizeView: View {
    
    @Binding var isAnimating: Bool
    
    var body: some View {
        Text("default max size loading view - usually used in full screen/width loading")
        LoadingViewSwiftUI(isAnimating: isAnimating)
            .defaultMaxSize()
        Divider().padding()
    }
}

struct LoadingViewExampleCustomSizeView: View {
    
    @Binding var isAnimating: Bool
    
    var body: some View {
        Text("custom size (120 width) loading view - use with care for custom usages")
        LoadingViewSwiftUI(isAnimating: isAnimating)
            .customWidth(120)
        Divider().padding()
    }
}

struct LoadingViewInsideButtonView: View {
    
    var body: some View {
        VStack {
            LoadingButtonExample(loadingColor: UIColor.horizonPrimary)
            LoadingButtonExample(loadingColor: UIColor.horizonNeutral000)
        }
    }
}

struct LoadingButtonExample: View {
    
    @State private var isAnimating: Bool = false
    @State private var buttonText: String = "Touch me"
    let loadingColor: UIColor
    
    var body: some View {
        SwiftUI.Button {
            withAnimation {
                self.isAnimating.toggle()
                self.buttonText = self.isAnimating ? " " : "Touch me"
            }
        } label: {
            ZStack {
                Text(buttonText)
                    .frame(width: 120)
                LoadingViewSwiftUI(isAnimating: isAnimating, color: loadingColor)
                    .customWidth(20)
                    .frame(alignment: .center)
                    // allows loading view to pass touches to underlying view
                    .allowsHitTesting(false)
                    .opacity(isAnimating ? 1.0 : 0)
            }
        }
    }
}

struct LoadingViewExampleView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingViewExampleView()
    }
}
