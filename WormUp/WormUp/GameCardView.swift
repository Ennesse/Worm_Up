//
//  GameCardView.swift
//  WormUp
//
//  Created by Siria Neri on 17/11/2026.
//

import SwiftUI

struct GameCardView: View {
    let section: GameSection

    var body: some View {
        VStack {
            Text(section.name)
                .font(.title2)
                .bold()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 3)
    }
}
