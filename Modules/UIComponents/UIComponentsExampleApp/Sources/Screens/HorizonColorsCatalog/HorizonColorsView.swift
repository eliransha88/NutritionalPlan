//
//  HorizonColorsView.swift
//  Kingfisher
//
//  Created by Alon Zilbershtein on 09/07/2022.
//

import SwiftUI

struct HorizonComponentsColorsView: View {
    
    struct Constants {
        static let title = "Horizon Colors"
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
                HorizonColorsView()
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

struct HorizonColorsView: View {
    let listOfHorizonColors: [UIColor] = [.horizonPrimary050, .horizonPrimary100, .horizonPrimary200, .horizonPrimary300, .horizonPrimary400, .horizonPrimary500, .horizonPrimary600, .horizonPrimary700, .horizonPrimary, .horizonPrimary900, .horizonSecondary050, .horizonSecondary100, .horizonSecondary200, .horizonSecondary300, .horizonSecondary400, .horizonSecondary500, .horizonSecondary600, .horizonSecondary800, .horizonSecondary900, .horizonNeutral000, .horizonNeutral050, .horizonNeutral100, .horizonNeutral200, .horizonNeutral300, .horizonNeutral400, .horizonNeutral500, .horizonNeutral600, .horizonNeutral700, .horizonNeutral800, .horizonNeutral900, .horizonNeutral950, .horizonError700, .horizonError100, .horizonSuccess700, .horizonSuccess100, .horizonWarning700, .horizonWarning100, .horizonInfo700, .horizonInfo100]
    
    var body: some View {
        Form {
            ForEach(listOfHorizonColors, id: \.self) { color in
                HStack {
                    VStack {
                        Text(color.name)
                        Text(color.toHexString())
                    }
                    Spacer()
                    Text("")
                        .frame(width: 90, height: 80, alignment: .trailing)
                        .background(Color(color))
                        .padding(24)
                }.frame(maxWidth: .infinity)
            }
        }
    }
}

extension UIColor {
    /// Name of color. Only colors created with XCode Color Assets will return actual name, colors created programatically will always return nil.
    var name: String {
        let str = String(describing: self).dropLast()
        guard let nameRange = str.range(of: "name = ") else {
            return ""
        }
        let cropped = str[nameRange.upperBound ..< str.endIndex]
        if cropped.isEmpty {
            return ""
        }
        return String(cropped)
    }
}

struct HorizonColorsView_Previews: PreviewProvider {
    static var previews: some View {
        HorizonColorsView()
    }
}
