//
//  MemoryView.swift
//  WormUp
//
//  Created by Siria Neri on 25/11/2026.
//

import SwiftUI

struct MemoryGameView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    
    enum Fase {
        case guarda
        case ripeti
        case risultato
    }
    
    let lunghezze = [3, 3, 4, 4, 5, 6]
    let passo = 1.0
    let accesa = 0.7
    let colonne = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]
    
    @State var numero = 0
    @State var punteggio = 0
    @State var sequenza: [Int] = []
    @State var inserita: [Int] = []
    @State var acceso: Int? = nil
    @State var premuto: Int? = nil
    @State var esito = false
    @State var fase = Fase.guarda
    @State var finito = false
    
    var body: some View {
        ZStack {
            rosaGioco.ignoresSafeArea()
            
            if finito {
                schermataFinale
            } else {
                schermataGioco
            }
        }
        .onAppear {
            nuovoRound()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var schermataGioco: some View {
        VStack(spacing: 14) {
            
            HStack(spacing: 12) {
                HStack {
                    Image(systemName: "brain")
                    Text("\(numero + 1)/6")
                        .bold()
                    ProgressView(value: Double(numero + 1), total: 6)
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
                    Text("Watch and repeat")
                        .font(.largeTitle)
                        .bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                    Text("Remember the order of the tiles.")
                        .font(.subheadline)
                }
                
                Spacer()
                
                Image("Memory")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
            }
            
            VStack(spacing: 10) {
                HStack {
                    Text("PATTERN")
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("\(sequenza.count) tiles")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                
                LazyVGrid(columns: colonne, spacing: 10) {
                    ForEach(0..<9, id: \.self) { indice in
                        Text(numeroTessera(indice))
                            .font(.system(size: 24, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .background(colore(indice))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .onTapGesture {
                                tocca(indice)
                            }
                    }
                }
                .frame(maxWidth: 300)
                .animation(.easeInOut(duration: 0.2), value: acceso)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            if fase == .risultato {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(esito ? "Correct!" : "Not quite")
                                .font(.headline)
                                .foregroundStyle(bluGioco)
                            
                            Text("Sequence of \(sequenza.count) tiles")
                                .font(.title3)
                                .bold()
                            
                            Text(esito ? "You repeated every tile in the right order." : "The numbers on the tiles show the right order.")
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Image(esito ? "RealWorm" : "Attention")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                    }
                    
                    Button {
                        avanti()
                    } label: {
                        Text(numero == 5 ? "See results" : "Next")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(bluGioco)
                            .clipShape(Capsule())
                    }
                }
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 6)
            } else {
                Text(fase == .guarda ? "Watch carefully..." : "Your turn! Tap the tiles in the same order.")
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(bluGioco)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
        }
        .padding()
    }
    
    var schermataFinale: some View {
        VStack(spacing: 20) {
            Text("Nice Worm Up!")
                .font(.largeTitle)
                .bold()
            
            Text("You got \(punteggio) out of 6")
            
            Image("RealWorm")
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
            
            
            Button {
                openURL(URL(string: "shortcuts://run-shortcut?name=WarmUpFocus")!)
            } label: {
                HStack {
                    Image(systemName: "moon")
                    Text("Set Focus Mode")
                        .bold()
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundStyle(bluGioco)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
        .padding()
    }
    
    func colore(_ indice: Int) -> Color {
        if fase == .risultato {
            if premuto == indice {
                return Color.gray.opacity(0.5)
            }
            if sequenza.contains(indice) {
                return bluGioco
            }
            return rosaGioco
        }
        if acceso == indice {
            return bluGioco
        }
        if inserita.contains(indice) {
            return bluGioco.opacity(0.6)
        }
        return rosaGioco
    }
    
    func numeroTessera(_ indice: Int) -> String {
        if fase == .risultato && sequenza.contains(indice) {
            return "\(sequenza.firstIndex(of: indice)! + 1)"
        }
        return ""
    }
    
    func nuovoRound() {
        sequenza = Array((0..<9).shuffled().prefix(lunghezze[numero]))
        inserita = []
        premuto = nil
        acceso = nil
        esito = false
        fase = .guarda
        
        for (i, indice) in sequenza.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 + Double(i) * passo) {
                acceso = indice
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 + accesa + Double(i) * passo) {
                acceso = nil
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 + Double(sequenza.count) * passo) {
            fase = .ripeti
        }
    }
    
    func tocca(_ indice: Int) {
        if fase == .ripeti && inserita.contains(indice) == false {
            if sequenza[inserita.count] == indice {
                inserita.append(indice)
                if inserita.count == sequenza.count {
                    esito = true
                    punteggio += 1
                    fase = .risultato
                }
            } else {
                premuto = indice
                esito = false
                fase = .risultato
            }
        }
    }
    
    func avanti() {
        if numero == 5 {
            finito = true
        } else {
            numero += 1
            nuovoRound()
        }
    }
}

#Preview {
    NavigationStack {
        MemoryGameView()
    }
}
