//
//  HorizonTypographyView.swift
//  UIComponents-ExampleApp
//
//  Created by Alon Zilbershtein on 11/07/2022.
//

import SwiftUI
import UIComponents

struct HorizonTypographyComponentsView: View {
    
    struct Constants {
        static let title = "Horizon Typography"
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
                HorizonTypographyView()
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

struct HorizonTypographyView: View {
    
    var body: some View {
        Form {
            Group {
                Text("H1 Bold")
                    .horizonTypographyH1Bold()
                Text("H1 Medium")
                    .horizonTypographyH1Medium()
                Text("H2 Bold")
                    .horizonTypographyH2Bold()
                Text("H2 Medium")
                    .horizonTypographyH2Medium()
                Text("H3 Medium")
                    .horizonTypographyH3Medium()
                Text("H3 Bold")
                    .horizonTypographyH3Bold()
                Text("H3 Regular")
                    .horizonTypographyH3Regular()
                Text("H3 Medium")
                    .horizonTypographyH3Medium()
            }
            Group {
                Text("H4 Bold")
                    .horizonTypographyH4Bold()
                Text("H4 Medium")
                    .horizonTypographyH4Medium()
                Text("H4 Regular")
                    .horizonTypographyH4Regular()
                Text("H5 Medium")
                    .horizonTypographyH5Medium()
                Text("H5 Bold")
                    .horizonTypographyH5Bold()
                Text("H5 Regular")
                    .horizonTypographyH5Regular()
                Text("H6 Medium")
                    .horizonTypographyH6Medium()
                Text("H6 Regular")
                    .horizonTypographyH6Regular()
            }
            Group {
                Text("Subtitle Bold")
                    .horizonTypographySubtitleBold()
                Text("Subtitle Medium")
                    .horizonTypographySubtitleMedium()
                Text("Subtitle Regular")
                    .horizonTypographySubtitleRegular()
                Text("Body1 Regular")
                    .horizonTypographyBody1Regular()
                Text("Body1 Medium")
                    .horizonTypographyBody1Medium()
                Text("Body1 Bold")
                    .horizonTypographyBody1Bold()
                Text("Body1 Paragraph")
                    .horizonTypographyBody1Paragraph()
            }
            Group {
                Text("Body2 Regular")
                    .horizonTypographyBody2Regular()
                Text("Body2 Medium")
                    .horizonTypographyBody2Medium()
                Text("Body2 Bold")
                    .horizonTypographyBody2Bold()
                Text("Body2 Paragraph")
                    .horizonTypographyBody2Paragraph()
                Text("Caption Regular")
                    .horizonTypographyCaptionRegular()
                Text("Caption Bold")
                    .horizonTypographyCaptionBold()
                Text("Button Large")
                    .horizonTypographyButtonLg()
                Text("Button Medium")
                    .horizonTypographyButtonMd()
                Text("Button Small")
                    .horizonTypographyButtonSm()
                Text("Button XSmall")
                    .horizonTypographyButtonXs()
            }
        }
    }
}

struct HorizonTypographyView_Previews: PreviewProvider {
    static var previews: some View {
        HorizonTypographyView()
    }
}
