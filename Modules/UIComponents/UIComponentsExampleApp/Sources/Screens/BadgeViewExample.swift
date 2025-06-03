//
//  BadgeViewExample.swift
//  UIComponents
//
//  Created by Eliran Sharabi on 21/02/2024.
//

import SwiftUI
import UIComponents

struct BadgeViewExample: View {
    
    @State private var showIcon: Bool = true
    @State private var showStroke: Bool = true
    @State private var bgColor: Color = .horizonSecondary100
    @State private var foregroundColor: Color = .horizonSecondary600
    @State private var iconColor: Color = .horizonSecondary500
    @State private var strokeColor: Color = .horizonBorder
    @State private var iconEdge: IconConfiguration.Edge = .leading
    
    var body: some View {
        List {
            
            Section("Horizon Badges:") {
                VStack {
                    HStack {
                        HorizonBadge(label: "Info", showIcon: showIcon, theme: .info)
                        HorizonBadge(label: "Success", showIcon: showIcon, theme: .success)
                    }
                    HStack {
                        HorizonBadge(label: "Warning", showIcon: showIcon, theme: .warning)
                        HorizonBadge(label: "Error", showIcon: showIcon, theme: .error)
                    }
                }
            }
            
            Section("Make your own badge:") {
                VStack(alignment: .leading, spacing: .xsSpacing, content: {
                    Text("Make your own badge:")
                        .horizonTypographyH5Bold()
                    
                        ColorPicker("Choose your background color", selection: $bgColor)
                        ColorPicker("Choose your foreground color", selection: $foregroundColor)
                        ColorPicker("Choose your icon color", selection: $iconColor)
                        ColorPicker("Choose your stroke color", selection: $strokeColor)
                        Picker("Select icon edge", selection: $iconEdge) {
                            ForEach(IconConfiguration.Edge.allCases, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        Toggle(isOn: $showStroke) {
                            Text("Show stroke")
                        }
                        
                        Toggle(isOn: $showIcon) {
                            Text("Show icon")
                        }
                        
                        HorizonBadge(
                            label: "Custom",
                            theme: .custom(
                                style: .init(
                                    icon: .init(image: UIImage(systemSymbol: .bookmarkCircleFill),
                                                color: iconColor, edge: iconEdge),
                                    backgroundColor: bgColor,
                                    foregroundColor: foregroundColor,
                                    strokeColor: showStroke ? strokeColor : nil
                                )
                            )
                        )
                        .padding(.vertical, .mediumSpacing)
                })
            }
            .listStyle(.grouped)
        }
        
    }
}
