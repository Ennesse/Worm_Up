//
//  GameCardView.swift
//  MyApp
//
//  Created by Siria Neri on 12/11/2026.
//

import SwiftUI

struct GameCardView: View {
    let section : GameSection
   
    var body: some View {
        
        VStack(alignment: .leading) {
                    Image(systemName: section.icon)
                        .frame(width: 36, height: 36)
                        .background(Color.indigo.opacity(0.15))
                        .clipShape(Circle())

                    Spacer()

                    Text(section.name).font(.headline)
                    Text(section.subtitle).font(.caption).foregroundColor(.gray)
                }
                .padding(12)
                .frame(maxWidth: .infinity, minHeight: 115, alignment: .leading)
                .background(Color.white)
                .cornerRadius(16)
            }
    }


