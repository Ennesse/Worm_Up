//
//  ShapeView.swift
//  WormUp
//
//  Created by Siria Neri on 23/11/2026.
//

import SwiftUI
import Combine

struct ShapeMatchView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var numero = 0
    @State var punteggio = 0
    @State var tempo = 14
    @State var riferimento = pentomini[0]
    @State var opzioni: [Opzione] = []
    @State var scelta: Int? = nil
    @State var esito = false
    @State var mostraPopup = false
    @State var finito = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let colonne = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            rosaGioco.ignoresSafeArea()
            
            if finito {
                VStack(spacing: 20) {
                    Text("Nice Warm Up!")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("You got \(punteggio) out of 6")
                    
                    Image("Attention")
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
                            .background(bluGioco)
                            .clipShape(Capsule())
                    }
                }
                .padding()
            } else {
                VStack(spacing: 16) {
                    
                    HStack(spacing: 12) {
                        HStack {
                            Image(systemName: "clock")
                            Text(String(format: "0:%02d", tempo))
                                .bold()
                            ProgressView(value: Double(tempo), total: 14)
                                .tint(bluGioco)
                        }
                        .foregroundStyle(bluGioco)
                        .padding(10)
                        .background(.white)
                        .clipShape(Capsule())
                        
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(.white)
                                .frame(width: 40, height: 40)
                                .background(bluGioco)
                                .clipShape(Circle())
                        }
                    }
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Find the match")
                                .font(.largeTitle)
                                .bold()
                            Text("Turn it, don't flip it.")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Image("Attention")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 90)
                    }
                    
                    ZStack {
                        ShapeView(forma: riferimento, lato: 22)
                        
                        VStack {
                            HStack {
                                Text("REFERENCE")
                                    .font(.caption2)
                                    .bold()
                                    .foregroundStyle(.secondary)
                                Spacer()
                            }
                            Spacer()
                            HStack {
                                Spacer()
                                Text("Shape \(numero + 1) of 6")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 160)
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Text("Tap the matching shape")
                        .font(.caption)
                    
                    LazyVGrid(columns: colonne, spacing: 12) {
                        ForEach(Array(opzioni.enumerated()), id: \.element.id) { indice, opzione in
                            ZStack(alignment: .topLeading) {
                                ShapeView(forma: opzione.forma, lato: 16)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                
                                Text(["A", "B", "C", "D"][indice])
                                    .font(.caption2)
                                    .bold()
                                    .foregroundStyle(bluGioco)
                                    .frame(width: 22, height: 22)
                                    .background(Color(red: 0.75, green: 0.85, blue: 0.97))
                                    .clipShape(Circle())
                            }
                            .frame(height: 100)
                            .padding(8)
                            .background(scelta == indice ? Color.gray.opacity(0.5) : Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .onTapGesture {
                                scegli(indice)
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .overlay {
            if mostraPopup {
                VStack(spacing: 12) {
                    Text(esito ? "You're the real bookworm!" : (scelta == -1 ? "Time's up!" : "Not this one!"))
                        .font(.headline)
                        .multilineTextAlignment(.center)
                    
                    Image("Attention")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 10)
                .padding(40)
            }
        }
        .onAppear {
            nuovoRound()
        }
        .onReceive(timer) { _ in
            if scelta == nil && finito == false {
                tempo -= 1
                if tempo == 0 {
                    scelta = -1
                    esito = false
                    mostraPopup = true
                    vaiAvanti()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func nuovoRound() {
        let base = pentomini.randomElement()!
        let giusta = Opzione(forma: ruotaVolte(base, volte: Int.random(in: 1...3)), giusta: true)
        let rotazioni = [0, 1, 2, 3].shuffled()
        
        var lista = [giusta]
        for i in 0..<3 {
            lista.append(Opzione(forma: ruotaVolte(specchia(base), volte: rotazioni[i]), giusta: false))
        }
        
        riferimento = base
        opzioni = lista.shuffled()
        tempo = 14
        scelta = nil
        mostraPopup = false
    }
    
    func scegli(_ indice: Int) {
        if scelta == nil {
            scelta = indice
            esito = opzioni[indice].giusta
            if esito {
                punteggio += 1
            }
            mostraPopup = true
            vaiAvanti()
        }
    }
    
    func vaiAvanti() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if numero == 5 {
                finito = true
                mostraPopup = false
            } else {
                numero += 1
                nuovoRound()
            }
        }
    }
}

#Preview {
    NavigationStack {
        ShapeMatchView()
    }
}
