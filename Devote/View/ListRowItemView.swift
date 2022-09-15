//
//  ListRowItemView.swift
//  Devote
//
//  Created by hazem smawy on 9/14/22.
//

import SwiftUI

struct ListRowItemView: View {
    // MARK: - Property
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item : Item
    
    // MARK: - Body
    var body: some View {
        Toggle(isOn:$item.completion) {
            Text(item.task ?? "")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(item.completion ? .pink : .primary)
                .padding(.vertical , 12)
                .animation(.default)
        }//:Toggle
        .toggleStyle(CheckBoxStyle())
        .onReceive(item.objectWillChange) { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        }
    }
}

