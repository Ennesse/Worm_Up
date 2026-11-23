//
//  InstructionsView.swift
//  WormUp
//
//  Created by Siria Neri on 23/11/2026.
//

import SwiftUI

struct InstructionsView: View {
    let istruzione: Instruction
    @Environment(\.dismiss) var dismiss
    
    let blu = Color(red: 0.31, green: 0.36, blue: 0.67)
    let rosa = Color(red: 1.0, green: 0.91, blue: 0.91)
    
    @ViewBuilder
    func giocoGiusto() -> some View {
        switch istruzione.categoria.uppercased() {
        case "ATTENTION":
            ShapeMatchView()
        case "MEMORY":
            Text("Gioco Memory in arrivo")
        case "LANGUAGE":
            Text("Gioco Language in arrivo")
        case "LOGIC":
            Text("Gioco Logic in arrivo")
        default:
            Text("Gioco non trovato")
        }
    }
    
    var body: some View {
        ZStack {
            rosa.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    ZStack {
                        Text(istruzione.categoria)
                            .font(.headline)
                            .foregroundStyle(blu)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(.white)
                            .clipShape(Capsule())
                        
                        HStack {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "arrow.left")
                                    .foregroundStyle(.white)
                                    .frame(width: 36, height: 36)
                                    .background(blu)
                                    .clipShape(Circle())
                            }
                            
                            Spacer()
                        }
                    }
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(istruzione.titolo)
                                .font(.largeTitle)
                                .bold()
                            
                            Text(istruzione.subtitle)
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        istruzione.immagine
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                    }
                    
                    VStack {
                        istruzione.im_In
                            .resizable()
                            .scaledToFit()
                            .frame(height: 80)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(Array(istruzione.passi.enumerated()), id: \.offset) { indice, passo in
                            HStack(alignment: .top, spacing: 12) {
                                Text("\(indice + 1)")
                                    .font(.subheadline)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .frame(width: 28, height: 28)
                                    .background(blu)
                                    .clipShape(Circle())
                                
                                VStack(alignment: .leading) {
                                    Text(passo.titolo)
                                        .font(.headline)
                                    Text(passo.descrizione)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                    
                    /*Button {
                        
                    } label: {
                        Text("I'm ready!")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(blu)
                            .clipShape(Capsule())
                    }*/
                    
                    NavigationLink {
                        giocoGiusto()
                    } label: {
                        Text("I'm ready!")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(blu)
                            .clipShape(Capsule())
                    }
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    InstructionsView(istruzione: all[0])
}
