//
//  ModalViewExampleView.swift
//  UIComponentsExampleApp
//
//  Created by Itamar Manor on 29/01/2024.
//

import SwiftUI
import Combine
import UIComponents

struct ModalViewExampleView: View {
    @State private var appearance: HorizonModalAppearance = .modal
    @State private var topViewBackgroundColor: Color = .clear
    @State private var isTopImageShowing: Bool = false
    @State private var isDismissButtonShowing: Bool = true
    @State private var isIconShowing: Bool = true
    @State private var isBadgeShowing: Bool = true
    @State private var isTitleShowing: Bool = true
    @State private var isSubtitleShowing: Bool = true
    @State private var isLinkShowing: Bool = true
    @State private var isDividerShowing: Bool = true
    @State private var isDescriptionShowing: Bool = true
    @State private var isCustomViewShowing: Bool = true
    @State private var buttons: ButtonsDataExamples = .none
    @State private var isMinusculeShowing: Bool = true
    @State private var isDismissedByOutsideTap: Bool = true
    @State private var isAutoDismissing: Bool = false
    
    @State private var horizonModalConfig: HorizonModalConfiguration = HorizonModalConfiguration()
    @State private var isModalPresented: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                makePicker(title: "Appearance", selection: $appearance, data: HorizonModalAppearance.allCases)
                ColorPicker("Choose Background Color", selection: $topViewBackgroundColor)
                Toggle("Top Image", isOn: $isTopImageShowing)
                Toggle("Dismiss Button", isOn: $isDismissButtonShowing)
                Toggle("Icon", isOn: $isIconShowing)
                Toggle("Badge", isOn: $isBadgeShowing)
                Toggle("Title", isOn: $isTitleShowing)
                Toggle("Subtitle", isOn: $isSubtitleShowing)
                Toggle("Link", isOn: $isLinkShowing)
                Toggle("Divider", isOn: $isDividerShowing)
                Toggle("Description", isOn: $isDescriptionShowing)
                Toggle("Custom View", isOn: $isCustomViewShowing)
                makePicker(title: "Button Style", selection: $buttons, data: ButtonsDataExamples.allCases.compactMap { $0 })
                Toggle("Minuscule Text", isOn: $isMinusculeShowing)
                Toggle("Tap Outside To Dismiss Config", isOn: $isDismissedByOutsideTap)
                Toggle("Auto dismiss after 5 seconds", isOn: $isAutoDismissing)
                Button("Show Modal") {
                    updateModalConfiguration()
                    isModalPresented = true
                }
                Spacer()
            }
            .padding(.horizontal, 20.0)
        }
        .navigationBarTitle("Modals")
        .horizonModal(with: $horizonModalConfig,
                      isPresented: $isModalPresented,
                      onModalAppear: {  },
                      onModalCancel: { self.isModalPresented = false },
                      onModalDismiss: { self.isModalPresented = false })
    }
    
    private func updateModalConfiguration() {
        let topImage: UIImage? = isTopImageShowing ? UIComponentsAssets.announcementIllustration.image : nil
        let icon = isIconShowing ? IconData(iconType: .illustration(UIComponentsAssets.announcementIllustration.image), backgroundColor: .horizonSecondary050) : nil
        let badge = isBadgeShowing ? BadgeData(label: "This is a badge", theme: .success) : nil
        let title = isTitleShowing ? LabelData(text: .text("This is a title")) : LabelData(text: .text(""))
        let subtitle = isSubtitleShowing ? LabelData(text: .text("This is a subtitle")) : nil
        let link = isLinkShowing ? LinkData(label: "This is a link", onTap: {}) : nil
        let description = isDescriptionShowing ? LabelData(text: .text("This is a description")) : nil
        let customView = isCustomViewShowing ? HorizonButtonView(kind: .tertiary(titleColor: .blue), dimension: .large, text: "This is a CustomView", action: {}) : nil
        let minuscule = isMinusculeShowing ? LabelData(text: .text("This is a minuscule")) : nil
        let autoDismissAfterSeconds: CGFloat? = isAutoDismissing ? 5.0 : nil
        
        horizonModalConfig = HorizonModalConfiguration(appearance: appearance,
                                                       accessibilityIdentifier: nil,
                                                       topViewBackgroundColor: topViewBackgroundColor,
                                                       topImage: topImage,
                                                       shouldShowDismissButton: isDismissButtonShowing,
                                                       icon: icon,
                                                       badge: badge,
                                                       title: title,
                                                       subtitle: subtitle,
                                                       link: link,
                                                       shouldShowDivider: isDividerShowing,
                                                       description: description,
                                                       customView: { customView },
                                                       buttons: buttons.example,
                                                       minuscule: minuscule,
                                                       shouldDismissWhenTappingOutside: isDismissedByOutsideTap,
                                                       autoDismissAfterSeconds: autoDismissAfterSeconds)
    }
    
    private func makePicker<T: Hashable>(title: String, selection: Binding<T>, data: [T]) -> some View {
        VStack {
            Text(title).textAlignment(.leading)
            Picker(title, selection: selection) {
                ForEach(data, id: \.self) { option in
                    Text("\(option)".capitalized).tag(option)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

extension HorizonModalAppearance: CaseIterable {
    public static var allCases: [HorizonModalAppearance] {
        return [.bottomSheet, .fullWidth, .modal]
    }
}

private enum ButtonsDataExamples: CaseIterable {
    case none
    case singleButton
    case twoButtons
    
    var example: UIComponents.ButtonsData? {
        switch self {
        case .none:
            return nil
        case .singleButton:
            return .singleButton(data: ButtonData(title: "Button title", onTap: {}), kind: HorizonButton.Kind.primary)
        case .twoButtons:
            return .twoButtons(primaryButtonData: ButtonData(title: "Primary button"), secondaryButtonData: ButtonData(title: "Secondary button"), secondaryButtonKind: .secondary, axis: .vertical)
        }
    }
}

