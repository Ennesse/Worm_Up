//
//  LogicView.swift
//  WormUp
//
//  Created by Siria Neri on 25/11/2026.
//

import SwiftUI
import Combine

struct Sequenza {
    let numeri: [Int]
    let risposta: Int
    let regola: String
    let spiegazione: String
}

func creaSequenza(tipo: Int) -> Sequenza {
    var n: [Int] = []
    var regola = ""
    var spiegazione = ""
    
    if tipo == 0 {
        let a = Int.random(in: 1...20)
        let d = Int.random(in: 2...9)
        n = (0..<6).map { a + d * $0 }
        regola = "Arithmetic sequence"
        spiegazione = "Each number is the previous one plus \(d). So after \(n[4]) comes \(n[4]) + \(d) = \(n[5])."
    } else if tipo == 1 {
        let a = Int.random(in: 1...4)
        let r = Int.random(in: 2...3)
        n = [a]
        for _ in 1..<6 {
            n.append(n.last! * r)
        }
        regola = "Geometric sequence"
        spiegazione = "Each number is the previous one multiplied by \(r). So after \(n[4]) comes \(n[4]) × \(r) = \(n[5])."
    } else if tipo == 2 {
        let a = Int.random(in: 5...20)
        let p = Int.random(in: 4...9)
        let q = Int.random(in: 1...3)
        n = [a]
        for i in 1..<6 {
            if i % 2 == 1 {
                n.append(n.last! + p)
            } else {
                n.append(n.last! - q)
            }
        }
        regola = "Alternating sequence"
        spiegazione = "The rule alternates: add \(p), subtract \(q), add \(p), and so on. After \(n[4]) it's time to add \(p), so the answer is \(n[5])."
    } else if tipo == 3 {
        let k = Int.random(in: 1...6)
        n = (0..<6).map { (k + $0) * (k + $0) }
        regola = "Square numbers"
        spiegazione = "These are square numbers: \(k)², \(k + 1)², \(k + 2)² and so on. The next one is \(k + 5)² = \(n[5])."
    } else if tipo == 4 {
        let a = Int.random(in: 1...5)
        let b = Int.random(in: 1...5)
        n = [a, b]
        for i in 2..<6 {
            n.append(n[i - 1] + n[i - 2])
        }
        regola = "Fibonacci-type sequence"
        spiegazione = "Each number is the sum of the two before it. So \(n[3]) + \(n[4]) = \(n[5])."
    } else {
        let a = Int.random(in: 1...10)
        let d = Int.random(in: 1...3)
        n = [a]
        for i in 0..<5 {
            n.append(n.last! + d + i)
        }
        regola = "Growing differences"
        spiegazione = "The gap grows by 1 each time: +\(d), +\(d + 1), +\(d + 2), +\(d + 3). The next gap is +\(d + 4), so \(n[4]) + \(d + 4) = \(n[5])."
    }
    
    return Sequenza(numeri: Array(n.prefix(5)), risposta: n[5], regola: regola, spiegazione: spiegazione)
}

func creaOpzioni(_ risposta: Int) -> [Int] {
    var lista = [risposta]
    let spread = max(4, risposta / 5)
    
    while lista.count < 4 {
        let candidato = risposta + Int.random(in: -spread...spread)
        if candidato > 0 && lista.contains(candidato) == false {
            lista.append(candidato)
        }
    }
    
    return lista.shuffled()
}

struct LogicGameView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    
    @State var sequenze: [Sequenza] = (0..<6).shuffled().map { creaSequenza(tipo: $0) }
    @State var numero = 0
    @State var punteggio = 0
    @State var tempo = 30
    @State var opzioni: [Int] = []
    @State var scelta: Int? = nil
    @State var esito = false
    @State var finito = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let colonne = [GridItem(.flexible()), GridItem(.flexible())]
    
    var corrente: Sequenza {
        sequenze[numero]
    }
    
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
            opzioni = creaOpzioni(corrente.risposta)
        }
        .onReceive(timer) { _ in
            if scelta == nil && finito == false {
                tempo -= 1
                if tempo == 0 {
                    scelta = -1
                    esito = false
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var schermataGioco: some View {
        VStack(spacing: 14) {
            
            HStack(spacing: 12) {
                HStack {
                    Image(systemName: "clock")
                    Text(String(format: "0:%02d", tempo))
                        .bold()
                    ProgressView(value: Double(tempo), total: 30)
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
                    Text("Next number")
                        .font(.largeTitle)
                        .bold()
                    Text("Find the rule behind the sequence.")
                        .font(.subheadline)
                }
                
                Spacer()
                
                Image("Logic")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
            }
            
            VStack(spacing: 10) {
                HStack {
                    Text("SEQUENCE")
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text("Round \(numero + 1) of 6")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
                
                HStack(spacing: 6) {
                    ForEach(Array(corrente.numeri.enumerated()), id: \.offset) { _, valore in
                        Text("\(valore)")
                            .font(.system(size: 20, weight: .heavy, design: .rounded))
                            .foregroundStyle(bluGioco)
                            .minimumScaleFactor(0.5)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(rosaGioco)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    Text(scelta == nil ? "?" : "\(corrente.risposta)")
                        .font(.system(size: 20, weight: .heavy, design: .rounded))
                        .foregroundStyle(.white)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(bluGioco)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            LazyVGrid(columns: colonne, spacing: 12) {
                ForEach(Array(opzioni.enumerated()), id: \.offset) { indice, valore in
                    ZStack(alignment: .topLeading) {
                        Text("\(valore)")
                            .font(.system(size: 28, weight: .heavy, design: .rounded))
                            .foregroundStyle(coloreTesto(indice))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        Text(["A", "B", "C", "D"][indice])
                            .font(.caption2)
                            .bold()
                            .foregroundStyle(bluGioco)
                            .frame(width: 22, height: 22)
                            .background(Color(red: 0.75, green: 0.85, blue: 0.97))
                            .clipShape(Circle())
                    }
                    .frame(height: 60)
                    .padding(8)
                    .background(sfondo(indice))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .onTapGesture {
                        scegli(indice)
                    }
                }
            }
            
            if scelta != nil {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(esito ? "Correct!" : (scelta == -1 ? "Time's up!" : "Not quite"))
                                .font(.headline)
                                .foregroundStyle(bluGioco)
                            
                            Text(corrente.regola)
                                .font(.title3)
                                .bold()
                            
                            Text(corrente.spiegazione)
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
    
    func sfondo(_ indice: Int) -> Color {
        if scelta == nil {
            return .white
        }
        if opzioni[indice] == corrente.risposta {
            return bluGioco
        }
        if scelta == indice {
            return Color.gray.opacity(0.5)
        }
        return .white
    }
    
    func coloreTesto(_ indice: Int) -> Color {
        if scelta != nil && opzioni[indice] == corrente.risposta {
            return .white
        }
        return bluGioco
    }
    
    func scegli(_ indice: Int) {
        if scelta == nil {
            scelta = indice
            esito = opzioni[indice] == corrente.risposta
            if esito {
                punteggio += 1
            }
        }
    }
    
    func avanti() {
        if numero == 5 {
            finito = true
        } else {
            numero += 1
            opzioni = creaOpzioni(corrente.risposta)
            tempo = 30
            scelta = nil
        }
    }
}

#Preview {
    NavigationStack {
        LogicGameView()
    }
}
