//
//  BlankView.swift
//  Devote
//
//  Created by hazem smawy on 9/14/22.
//

import SwiftUI

struct BlankView: View {
    // MARK: - Property
    var backgroundColor: Color
    var backgroundOpacity:Double
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0 , maxWidth: .infinity, minHeight: 0 , maxHeight: .infinity, alignment: .center)
        .background(backgroundColor)
        .opacity(backgroundOpacity)
        .edgesIgnoringSafeArea(.all)
        .blendMode(.overlay)
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView(backgroundColor: .black, backgroundOpacity: 0.3)
            .background(BackgroundView())
            .background(backgroundGradient.ignoresSafeArea(.all))
    }
}
