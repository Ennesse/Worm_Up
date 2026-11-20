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
        VStack(alignment: .center, spacing: 12) {

                Text(section.name)
                .font(.title2)
                .bold()
                .foregroundColor(Color.black)

            Text(section.subtitle)
                .font(.caption)
                .foregroundColor(.gray)
            
            section.icon
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
#Preview {
    GameCardView(section: GameSection(name: "test", subtitle: "test", icon: Image (systemName: "heart.fill")))
}
