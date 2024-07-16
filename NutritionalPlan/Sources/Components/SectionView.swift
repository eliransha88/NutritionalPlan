//
//  SectionView.swift
//  NutritionalPlan
//
//  Created by Eliran Sharabi on 08/07/2024.
//

import SwiftUI

struct SectionView<Content: View>: View {
    
    let title: String
    let rowInsets: EdgeInsets
    let content: Content
    
    init(_ title: String,
         rowInsets: EdgeInsets = .init(.zero),
         @ViewBuilder content: () -> Content) {
        self.title = title
        self.rowInsets = rowInsets
        self.content = content()
    }
    
    var body: some View {
        Section {
            content
        } header: {
            Text(title)
                .font(.headline)
                .foregroundStyle(Color.primary)
                .padding(.vertical, 16.0)
        }
        .listRowInsets(rowInsets)
    }
}

struct SectionWithButtonView<Content: View, Parent : View>: View {
    
    let title: String
    let rowInsets: EdgeInsets
    let content: Content
    let buttonContent: Parent
    let onButtonTap: VoidHandler
    
    init(_ title: String,
         rowInsets: EdgeInsets = .init(.zero),
         @ViewBuilder content: () -> Content,
         @ViewBuilder buttonContent: () -> Parent,
         onButtonTap: @escaping VoidHandler) {
        self.title = title
        self.rowInsets = rowInsets
        self.content = content()
        self.buttonContent = buttonContent()
        self.onButtonTap = onButtonTap
    }
    
    var body: some View {
        Section {
            content
        } header: {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(Color.primary)
                
                Spacer()
                
                Button {
                    onButtonTap()
                } label: {
                    buttonContent
                }
            }
            .padding(.vertical, 16.0)
        }
        .listRowInsets(rowInsets)
    }
}
