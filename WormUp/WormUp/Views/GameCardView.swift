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
    
    var immagineSinistra: Bool {
        section.name == "Attention" || section.name == "Logic"
    }
    
    var senzaImmagine: Bool {
        section.name == "Language"
    }
    
    var body: some View {
        ZStack {
            if senzaImmagine == false {
                section.icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: immagineSinistra ? .bottomLeading : .bottomTrailing)
            }
            
            VStack(alignment: immagineSinistra ? .trailing : .leading, spacing: 2) {
                Text(section.name)
                    .font(.system(size: 22, weight: .heavy, design: .rounded))
                    .foregroundStyle(blu)
                
                Text(section.subtitle)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(blu)
                    .multilineTextAlignment(immagineSinistra ? .trailing : .leading)
            }
            .padding(.leading, immagineSinistra ? 50 : 0)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: immagineSinistra ? .topTrailing : .topLeading)
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
