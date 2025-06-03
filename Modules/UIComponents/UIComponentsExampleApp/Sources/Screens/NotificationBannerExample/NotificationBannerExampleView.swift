//
//  NotificationBannerExampleView.swift
//  UIComponentsExampleApp
//
//  Created by Itamar Manor on 29/01/2024.
//

import SwiftUI
import UIComponents

struct NotificationBannerExampleView: View {
    @State private var style: NotificationBannerConfig.Style = .success
    @State private var position: NotificationBannerConfig.Position = .top
    @State private var autoDismissOption: AutoDismissOption = .short
    @State private var titleText: String = "title..."
    @State private var subtitleText: String = "subtitle..."
    @State private var ctaTitleText: String = "cta button title..."
    @State private var isXButtonShowing: Bool = false
    @State private var isBannerPresented: Bool = false
    
    private var notificationBannerConfig: NotificationBannerConfig {
        return NotificationBannerConfig(style: style,
                                        position: position,
                                        title: .text(titleText),
                                        subtitle: .text(subtitleText),
                                        ctaTitle: .text(ctaTitleText),
                                        showDismissButton: isXButtonShowing,
                                        autoDismissAfter: autoDismissOption.duration)
    }
    
    var body: some View {
        VStack(spacing: 24.0) {
            Spacer()
            makeTextField(binding: $titleText)
            makeTextField(binding: $subtitleText)
            makeTextField(binding: $ctaTitleText)
            
            makePicker(title: "Position", selection: $position, data: NotificationBannerConfig.Position.allCases)
            makePicker(title: "Style", selection: $style, data: NotificationBannerConfig.Style.allCases)
            makePicker(title: "Auto Dismiss", selection: $autoDismissOption, data: AutoDismissOption.allCases)
            
            toggleXButtonSwitch
            toggleBanner
            Spacer()
        }
        .navigationBarTitle("Notification Banner")
        .padding(20.0)
        .notificationBanner(isPresented: $isBannerPresented, notificationBannerConfig: notificationBannerConfig)
    }
    
    private func makeTextField(binding: Binding<String>) -> some View {
        TextField(binding.wrappedValue, text: binding)
            .textFieldStyle(.roundedBorder)
    }
    
    private func makePicker<T: Hashable>(title: String, selection: Binding<T>, data: [T]) -> some View {
        VStack {
            Text(title)
            Picker(title, selection: selection) {
                ForEach(data, id: \.self) { option in
                    Text("\(option)".capitalized).tag(option)
                }
            }
            .pickerStyle(.segmented)
        }
    }
    
    private var toggleXButtonSwitch: some View {
        Toggle("Show X Button", isOn: $isXButtonShowing)
    }
    
    private var toggleBanner: some View {
        Button("Toggle Banner") {
            withAnimation {
                isBannerPresented.toggle()
            }
        }.textAlignment(.center)
    }
}

extension NotificationBannerExampleView {
    
    private enum AutoDismissOption: CaseIterable {
        case off
        case short
        case long
        
        var duration: CGFloat? {
            switch self {
            case .off: return nil
            case .short: return 5.0
            case .long: return 10.0
            }
        }
    }
}

extension NotificationBannerConfig.Style: CaseIterable {
    public static var allCases: [NotificationBannerConfig.Style] {
        return [.success, .error, .warning, .info]
    }
}

extension NotificationBannerConfig.Position: CaseIterable {
    public static var allCases: [NotificationBannerConfig.Position] {
        return [.top, .bottom]
    }
}

#Preview {
    NotificationBannerExampleView()
}
