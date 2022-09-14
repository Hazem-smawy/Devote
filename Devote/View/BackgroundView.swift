//
//  BackgroundView.swift
//  Devote
//
//  Created by hazem smawy on 9/13/22.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image("rocket")
            .antialiased(true)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
