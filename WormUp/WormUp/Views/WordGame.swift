//
//  WordGame.swift
//  WormUp
//
//  Created by Siria Neri on 24/11/2026.
//

import SwiftUI
import Combine
import UIKit

struct LanguageGameView: View {
    @Environment(\.dismiss) var dismiss
    
    let blu = Color(red: 0.31, green: 0.36, blue: 0.67)
    let rosa = Color(red: 1.0, green: 0.91, blue: 0.91)
    
    let basi = ["PLASTER", "STORAGE", "MONSTER", "CHAPTER", "PAINTER"]
    
    @State var lettere: [String] = []
    @State var usate: [Int] = []
    @State var trovate: [String] = []
    @State var messaggio = ""
    @State var tempo = 120
    @State var finito = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let colonne = [GridItem(.adaptive(minimum: 90))]
    
    var parolaCorrente: String {
        usate.map { lettere[$0] }.joined()
    }
    
    var body: some View {
        ZStack {
            rosa.ignoresSafeArea()
            
            if finito {
                schermataFinale
            } else {
                schermataGioco
            }
        }
        .onAppear {
            nuovoGioco()
        }
        .onReceive(timer) { _ in
            if finito == false && tempo > 0 {
                tempo -= 1
                if tempo == 0 {
                    finito = true
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var schermataGioco: some View {
        VStack(spacing: 16) {
            
            HStack(spacing: 12) {
                HStack {
                    Image(systemName: "clock")
                    Text(String(format: "%d:%02d", tempo / 60, tempo % 60))
                        .bold()
                    ProgressView(value: Double(tempo), total: 120)
                        .tint(blu)
                }
                .foregroundStyle(blu)
                .padding(10)
                .background(.white)
                .clipShape(Capsule())
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                        .frame(width: 40, height: 40)
                        .background(blu)
                        .clipShape(Circle())
                }
            }
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Make words")
                        .font(.largeTitle)
                        .bold()
                    Text("Use only these letters. Find at least 10.")
                        .font(.subheadline)
                }
                
                Spacer()
                
                Image("Attention")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
            }
            
            Text(parolaCorrente.isEmpty ? " " : parolaCorrente)
                .font(.system(size: 32, weight: .heavy, design: .rounded))
                .foregroundStyle(blu)
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Text(messaggio)
                .font(.subheadline)
                .bold()
                .foregroundStyle(blu)
                .frame(height: 20)
            
            HStack(spacing: 8) {
                ForEach(Array(lettere.enumerated()), id: \.offset) { indice, lettera in
                    Button {
                        if usate.contains(indice) == false {
                            usate.append(indice)
                        }
                    } label: {
                        Text(lettera)
                            .font(.system(size: 26, weight: .heavy, design: .rounded))
                            .foregroundStyle(blu)
                            .frame(maxWidth: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .opacity(usate.contains(indice) ? 0.3 : 1)
                    }
                }
            }
            
            HStack(spacing: 12) {
                Button {
                    if usate.isEmpty == false {
                        usate.removeLast()
                    }
                } label: {
                    Image(systemName: "delete.left")
                        .font(.title3)
                        .foregroundStyle(blu)
                        .frame(width: 56, height: 56)
                        .background(.white)
                        .clipShape(Circle())
                }
                
                Button {
                    lettere.shuffle()
                    usate = []
                } label: {
                    Image(systemName: "shuffle")
                        .font(.title3)
                        .foregroundStyle(blu)
                        .frame(width: 56, height: 56)
                        .background(.white)
                        .clipShape(Circle())
                }
                
                Button {
                    invia()
                } label: {
                    Text("Enter")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(blu)
                        .clipShape(Capsule())
                }
            }
            
            HStack {
                Text("\(trovate.count) / 10 words")
                    .font(.headline)
                    .foregroundStyle(blu)
                
                Spacer()
                
                if trovate.count >= 10 {
                    Button {
                        finito = true
                    } label: {
                        Text("Finish")
                            .font(.subheadline)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 8)
                            .background(blu)
                            .clipShape(Capsule())
                    }
                }
            }
            
            ScrollView {
                LazyVGrid(columns: colonne, spacing: 8) {
                    ForEach(trovate, id: \.self) { parola in
                        Text(parola.uppercased())
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundStyle(blu)
                            .padding(.vertical, 8)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .clipShape(Capsule())
                    }
                }
            }
        }
        .padding()
    }
    
    var schermataFinale: some View {
        VStack(spacing: 20) {
            Text(trovate.count >= 10 ? "Nice Warm Up!" : "Time's up!")
                .font(.system(size: 40, weight: .heavy, design: .rounded))
                .foregroundStyle(blu)
            
            Text(trovate.count >= 10 ? "You found \(trovate.count) words" : "You found \(trovate.count) of 10 words")
                .font(.title3)
            
            Image(trovate.count >= 10 ? "RealWorm" : "Attention")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            
            Button {
                dismiss()
            } label: {
                Text("Done")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(blu)
                    .clipShape(Capsule())
            }
            
            if trovate.count < 10 {
                Button {
                    nuovoGioco()
                } label: {
                    Text("Try again")
                        .font(.headline)
                        .foregroundStyle(blu)
                }
            }
        }
        .padding()
    }
    
    func nuovoGioco() {
        lettere = basi.randomElement()!.map { String($0) }.shuffled()
        usate = []
        trovate = []
        messaggio = ""
        tempo = 120
        finito = false
    }
    
    func invia() {
        let parola = parolaCorrente.lowercased()
        
        if parola.count < 3 {
            mostra("Too short")
        } else if trovate.contains(parola) {
            mostra("Already found")
        } else if parolaValida(parola) {
            trovate.append(parola)
            mostra("Nice!")
        } else {
            mostra("Not a word")
        }
        
        usate = []
    }
    
    func parolaValida(_ parola: String) -> Bool {
        let controllo = UITextChecker()
        let intervallo = NSRange(location: 0, length: parola.utf16.count)
        let errore = controllo.rangeOfMisspelledWord(in: parola, range: intervallo, startingAt: 0, wrap: false, language: "en_US")
        return errore.location == NSNotFound
    }
    
    func mostra(_ testo: String) {
        messaggio = testo
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            messaggio = ""
        }
    }
}

#Preview {
    NavigationStack {
        LanguageGameView()
    }
}
