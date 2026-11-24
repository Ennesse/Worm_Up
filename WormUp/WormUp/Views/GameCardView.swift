//
//  GameCardView.swift
//  WormUp
//
//  Created by Siria Neri on 17/11/2026.
//

import SwiftUI

struct GameCardView: View {

    let section: GameSection

    let blu = Color(red: 0.18, green: 0.24, blue: 0.53)

    var body: some View {

        ZStack {

            // VERME SEMPRE A SINISTRA
            section.icon
                .resizable()
                .scaledToFit()
                .frame(width: 100)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .bottomLeading
                )

            // TESTO SEMPRE A DESTRA
            VStack(
                alignment: .trailing,
                spacing: 2
            ) {

                Text(section.name)
                    .font(.system(
                        size: 15,
                        weight: .heavy,
                        design: .rounded
                    ))
                    .foregroundStyle(blu)

                Text(section.subtitle)
                    .font(.system(
                        size: 14,
                        weight: .regular,
                        design: .rounded
                    ))
                    .foregroundStyle(blu)
                    .multilineTextAlignment(.trailing)
            }
            .padding(.leading, 75)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topTrailing
            )
        }
        .frame(height: 125)
        .padding(14)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    GameCardView(section: GameSection.all[0])
}
