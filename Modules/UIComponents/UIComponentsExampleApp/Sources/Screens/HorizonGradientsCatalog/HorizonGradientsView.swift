//
//  HorizonGradientsView.swift
//  UIComponents-ExampleApp
//
//  Created by Alon Zilbershtein on 10/07/2022.
//

import SwiftUI
import UIComponents

struct HorizonGradientsComponentsView: View {
    
    struct Constants {
        static let title = "Horizon Gradients"
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
                HorizonGradientsView()
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

struct HorizonGradientsView: View {
    
    let horizonGraidentTypes = HorizonGraidentType.allCases
    
    var body: some View {
        Form {
            ForEach(horizonGraidentTypes, id: \.rawValue) { type in
                HStack {
                    Text(type.rawValue)
                    Spacer()
                    HorizonLinearGradientView(type: type, startPoint: .leading, endPoint: .trailing)
                        .frame(width: 180, height: 80, alignment: .trailing)
                }
            }
        }
    }
}

struct HorizonGradientsView_Previews: PreviewProvider {
    static var previews: some View {
        HorizonGradientsView()
    }
}
